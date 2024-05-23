package servlets;

import dao.ProjectDao;
import dao.ProjectDaoImp;
import model.Project;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ProjectServlet", value = "/ProjectServlet")
public class ProjectServlet extends HttpServlet {
    private static final String ACTION_GET_ALL_PROJECTS = "getAllProjects";
    private static final String ACTION_DELETE_PROJECT = "deleteProject";
    private static final String ACTION_EDIT_PROJECT = "editProject";
    private static final String ACTION_ADD_PROJECT = "addProject";
    private static final String ACTION_SHOW_EDIT_PROJECT_FORM = "showEditProjectForm";
    private static final String ACTION_SHOW_ADD_PROJECT_FORM = "showAddProjectForm";

    private ProjectDao projectDao;

    public ProjectServlet() {
        super();
        projectDao = new ProjectDaoImp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case ACTION_GET_ALL_PROJECTS:
                getAllProjects(request, response);
                break;
            case ACTION_DELETE_PROJECT:
                deleteProject(request, response);
                break;
            case ACTION_SHOW_EDIT_PROJECT_FORM:
                showEditProjectForm(request, response);
                break;
            case ACTION_SHOW_ADD_PROJECT_FORM:
                showAddProjectForm(request, response);
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
            case ACTION_EDIT_PROJECT:
                editProject(request, response);
                break;
            case ACTION_ADD_PROJECT:
                addProject(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void getAllProjects(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Project> projects = projectDao.getAll();
        request.setAttribute("projects", projects);
        RequestDispatcher dispatcher = request.getRequestDispatcher("project-list.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        Project project = projectDao.get(projectId);
        if (project != null) {
            projectDao.delete(project);
        }
        response.sendRedirect("ProjectServlet?action=" + ACTION_GET_ALL_PROJECTS);
    }
    private void showEditProjectForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        Project existingProject = projectDao.get(projectId);
        request.setAttribute("project", existingProject);
        RequestDispatcher dispatcher = request.getRequestDispatcher("project-form.jsp");
        dispatcher.forward(request, response);
    }

    private void editProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        String projectName = request.getParameter("projectName");
        String description = request.getParameter("description");

        Date startDate;
        Date endDate;
        try {
            startDate = Date.valueOf(request.getParameter("startDate"));
            endDate = Date.valueOf(request.getParameter("endDate"));
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format.");
            showEditProjectForm(request, response);
            return;
        }

        double budget;
        try {
            budget = Double.parseDouble(request.getParameter("budget"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid budget format.");
            showEditProjectForm(request, response);
            return;
        }

        Project project = new Project(projectName, description, startDate, endDate, budget);
        project.setProjectId(projectId);

        projectDao.update(project);

        response.sendRedirect("ProjectServlet?action=" + ACTION_GET_ALL_PROJECTS);
    }

    private void showAddProjectForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("project-form.jsp");
        dispatcher.forward(request, response);
    }

    private void addProject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectName = request.getParameter("projectName");
        String description = request.getParameter("description");

        Date startDate;
        Date endDate;
        try {
            startDate = Date.valueOf(request.getParameter("startDate"));
            endDate = Date.valueOf(request.getParameter("endDate"));
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format.");
            showAddProjectForm(request, response);
            return;
        }

        double budget;
        try {
            budget = Double.parseDouble(request.getParameter("budget"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid budget format.");
            showAddProjectForm(request, response);
            return;
        }

        Project newProject = new Project(projectName, description, startDate, endDate, budget);
        projectDao.create(newProject);

        response.sendRedirect("ProjectServlet?action=" + ACTION_GET_ALL_PROJECTS);
    }
}
