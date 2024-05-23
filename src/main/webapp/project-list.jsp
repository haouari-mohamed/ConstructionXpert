<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Projets</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="my-4">Liste des Projets</h2>
    <a href="ProjectServlet?action=showAddProjectForm" class="btn btn-primary mb-4">Ajouter un Nouveau Projet</a>
    <div class="row">
        <c:forEach var="project" items="${projects}">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${project.projectName}</h5>
                        <p class="card-text">
                            <strong>Description:</strong> ${project.description}<br>
                            <strong>Date de Début:</strong> ${project.startDate}<br>
                            <strong>Date de Fin:</strong> ${project.endDate}<br>
                            <strong>Budget:</strong> ${project.budget}
                        </p>
                        <a href="ProjectServlet?action=showEditProjectForm&projectId=${project.projectId}" class="btn btn-warning">Modifier</a>
                        <a href="ProjectServlet?action=deleteProject&projectId=${project.projectId}" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce projet ?');">Supprimer</a>
                        <a href="TaskServlet?action=getTasksByProject&projectId=${project.projectId}" class="btn btn-info">Voir les Tâches</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
