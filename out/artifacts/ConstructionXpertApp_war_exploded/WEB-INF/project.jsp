
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Boxicons -->
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <!-- My CSS -->
    <link rel="stylesheet" href="../CSS/project-list.css.css">
    <title>AdminHub</title>
</head>
<body>


<!-- SIDEBAR -->
<section id="sidebar">
    <a href="#" class="brand">
        <i class='bx bxs-smile'></i>
        <span class="text"> Conctruct xpert</span>
    </a>
    <ul class="side-menu top">
        <li class="active">
            <a href="dashboard.jsp">
                <i class='bx bxs-dashboard' ></i>
                <span class="text">Dashboard</span>
            </a>
        </li>
        <li>
            <a href="/Megarama_war_exploded/movie">
                <i class='bx bxs-shopping-bag-alt' ></i>
                <span class="text">Project</span>
            </a>
        </li>


    </ul>
    <ul class="side-menu">

        <li>
            <a href="/Megarama_war_exploded/login" class="logout">
                <i class='bx bxs-log-out-circle' ></i>
                <span class="text">Logout</span>
            </a>
        </li>
    </ul>
</section>
<!-- SIDEBAR -->



<!-- CONTENT -->
<section id="content">
    <!-- NAVBAR -->
    <nav>
        <i class='bx bx-menu' ></i>

        <form action="#">
            <div class="form-input">

            </div>
        </form>
        <input type="checkbox" id="switch-mode" hidden>
        <label for="switch-mode" class="switch-mode"></label>

        <a href="#" class="profile">
            <img src="/images/admin.png">
        </a>
    </nav>
    <!-- NAVBAR -->

    <!-- MAIN -->
    <main>
        <div class="head-title">
            <div class="left">
                <h1>Dashboard</h1>
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Dashboard</a>
                    </li>
                    <li><i class='bx bx-chevron-right' ></i></li>
                    <li>
                        <a class="active" href="dashboard.jsp">Admin Mangement</a>
                    </li>
                </ul>
            </div>
            <button class="btn btn-primary btn-create" data-toggle="modal" data-target="#projectModal" onclick="resetForm()">Create New Project</button>
        </div>

        <ul class="box-info">
            <li>
                <i class='bx bxs-calendar-check' ></i>
                <span class="text">
						<h3>1020</h3>
						<p>Project</p>
					</span>
            </li>
            <li>
                <i class='bx bxs-group' ></i>
                <span class="text">
						<h3>2834</h3>
						<p>Tasks</p>
					</span>
            </li>
            <li>
                <i class='bx bxs-dollar-circle' ></i>
                <span class="text">
						<h3>643</h3>
						<p>Ressources</p>
					</span>
            </li>
        </ul>


        <div class="table-data">
            <div class="order">
                <h1>Project List</h1>

                <tbody>
                <div class="container">

                    <div class="row">
                        <c:forEach var="project" items="${projectList}">
                            <div class="col-md-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">${project.name}</h5>
                                        <p class="card-text">
                                            <strong>Description:</strong> ${project.description}<br>
                                            <strong>Start Date:</strong> ${project.startDate}<br>
                                            <strong>End Date:</strong> ${project.endDate}<br>
                                            <strong>Budget:</strong> ${project.budget}
                                        </p>
                                        <div class="card-buttons">
                                            <button class="btn btn-warning mr-2" data-toggle="modal" data-target="#projectModal" onclick="populateForm(${project.id}, '${project.name}', '${project.description}', '${project.startDate}', '${project.endDate}', ${project.budget})">Edit</button>
                                            <a href="ProjectServlet?action=delete&id=${project.id}" class="btn btn-danger mr-2">Delete</a>
                                            <a href="TaskServlet?action=list&projectId=${project.id}" class="btn btn-info">Manage Tasks</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                </tbody>
            </div>
        </div>
        <!-- Project Modal -->
        <div class="modal fade" id="projectModal" tabindex="-1" role="dialog" aria-labelledby="projectModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="projectModalLabel">Project Form</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProjectServlet" method="post" id="projectForm">
                            <input type="hidden" name="id" id="projectId">
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="startDate">Start Date</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required>
                            </div>
                            <div class="form-group">
                                <label for="endDate">End Date</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" required>
                            </div>
                            <div class="form-group">
                                <label for="budget">Budget</label>
                                <input type="number" class="form-control" id="budget" name="budget" required>
                            </div>
                            <button type="submit" class="btn btn-primary" id="formSubmitButton" name="action" value="create">Create</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            function resetForm() {
                document.getElementById('projectForm').reset();
                document.getElementById('projectId').value = '';
                document.getElementById('formSubmitButton').innerText = 'Create';
                document.getElementById('formSubmitButton').value = 'create';
                document.getElementById('projectModalLabel').innerText = 'Create Project';
            }

            function populateForm(id, name, description, startDate, endDate, budget) {
                document.getElementById('projectId').value = id;
                document.getElementById('name').value = name;
                document.getElementById('description').value = description;
                document.getElementById('startDate').value = startDate;
                document.getElementById('endDate').value = endDate;
                document.getElementById('budget').value = budget;
                document.getElementById('formSubmitButton').innerText = 'Update';
                document.getElementById('formSubmitButton').value = 'update';
                document.getElementById('projectModalLabel').innerText = 'Edit Project';
            }
        </script>

    </main>
    <!-- MAIN -->
</section>
<!-- CONTENT -->
<script src="../JS/dashboard.js"></script>
</body>
</html>