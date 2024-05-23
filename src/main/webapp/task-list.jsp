<!DOCTYPE html>
<html>
<head>
    <title>Liste des Taches</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="my-4">Liste des Taches</h1>
    <a href="TaskServlet?action=showAddTaskForm&projectId=${projectId}" class="btn btn-primary mb-4">Ajouter une Nouvelle Tache</a>
    <div class="row">
        <c:forEach var="task" items="${tasks}">
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${task.taskName}</h5>
                        <p class="card-text">
                            <strong>Description:</strong> ${task.description}<br>
                            <strong>Date de Debut:</strong> ${task.startDate}<br>
                            <strong>Date de Fin:</strong> ${task.endDate}<br>
                            <strong>Statut:</strong> ${task.status}
                        </p>
                        <a href="TaskServlet?action=showEditTaskForm&taskId=${task.taskId}" class="btn btn-warning">Modifier</a>
                        <a href="TaskServlet?action=deleteTask&taskId=${task.taskId}" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette tâche ?');">Supprimer</a>
                        <a href="ResourceServlet?action=getResourcesByTask&taskId=${task.taskId}" class="btn btn-info">Voir les Ressources</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
