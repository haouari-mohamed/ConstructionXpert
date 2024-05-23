package servlets;

import dao.TaskDao;
import dao.TaskDaoImp;
import model.Task;
import model.Task.Status;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "TaskServlet", value = "/TaskServlet")
public class TaskServlet extends HttpServlet {
    private TaskDao taskDao;

    public TaskServlet() {
        super();
        taskDao = new TaskDaoImp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "getAllTasks":
                getAllTasks(request, response);
                break;
            case "deleteTask":
                deleteTask(request, response);
                break;
            case "showEditTaskForm":
                showEditTaskForm(request, response);
                break;
            case "showAddTaskForm":
                showAddTaskForm(request, response);
                break;
            case "getTasksByProject":
                getTasksByProject(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "editTask":
                editTask(request, response);
                break;
            case "addTask":
                addTask(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void getAllTasks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Task> tasks = taskDao.getTasks();
            request.setAttribute("tasks", tasks);
            RequestDispatcher dispatcher = request.getRequestDispatcher("task-list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching tasks");
        }
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            Task task = taskDao.getTask(taskId);
            if (task != null) {
                taskDao.deleteTask(task);
            }
            response.sendRedirect("TaskServlet?action=getAllTasks");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting task");
        }
    }

    private void showEditTaskForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            Task existingTask = taskDao.getTask(taskId);
            request.setAttribute("task", existingTask);
            RequestDispatcher dispatcher = request.getRequestDispatcher("task-form.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error showing edit task form");
        }
    }

    private void showAddTaskForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            RequestDispatcher dispatcher = request.getRequestDispatcher("task-form.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error showing add task form");
        }
    }

    private void editTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            String taskName = request.getParameter("taskName");
            String description = request.getParameter("description");
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));
            Status status = Status.valueOf(request.getParameter("status"));

            Task task = new Task(taskId, taskName, description, startDate, endDate, status);
            taskDao.updateTask(task);

            response.sendRedirect("TaskServlet?action=getAllTasks");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error editing task");
        }
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String taskName = request.getParameter("taskName");
            String description = request.getParameter("description");
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));
            Status status = Status.valueOf(request.getParameter("status"));

            Task task = new Task(taskName, description, startDate, endDate, status);
            taskDao.addTask(task);

            response.sendRedirect("TaskServlet?action=getAllTasks");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding task");
        }
    }

    private void getTasksByProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            List<Task> tasks = taskDao.getTasksByProjectId(projectId); // Assuming this method exists
            request.setAttribute("tasks", tasks);
            RequestDispatcher dispatcher = request.getRequestDispatcher("task-list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching tasks by project");
        }
    }
}
