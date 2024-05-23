<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de Projet</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>${project != null ? "Modifier le Projet" : "Ajouter un Nouveau Projet"}</h2>
    <form action="ProjectServlet" method="post">
        <input type="hidden" name="action" value="${project != null ? 'editProject' : 'addProject'}">
        <c:if test="${project != null}">
            <input type="hidden" name="projectId" value="${project.projectId}">
        </c:if>
        <div class="form-group">
            <label for="projectName">Nom du Projet:</label>
            <input type="text" class="form-control" id="projectName" name="projectName" value="${project != null ? project.projectName : ''}" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description" rows="3" required>${project != null ? project.description : ''}</textarea>
        </div>
        <div class="form-group">
            <label for="startDate">Date de Début:</label>
            <input type="date" class="form-control" id="startDate" name="startDate" value="${project != null ? project.startDate : ''}" required>
        </div>
        <div class="form-group">
            <label for="endDate">Date de Fin:</label>
            <input type="date" class="form-control" id="endDate" name="endDate" value="${project != null ? project.endDate : ''}" required>
        </div>
        <div class="form-group">
            <label for="budget">Budget:</label>
            <input type="number" step="0.01" class="form-control" id="budget" name="budget" value="${project != null ? project.budget : ''}" required>
        </div>
        <button type="submit" class="btn btn-primary">${project != null ? "Modifier" : "Ajouter"}</button>
    </form>
    <c:if test="${error != null}">
        <div class="alert alert-danger mt-3">${error}</div>
    </c:if>
</div>
</body>
</html>
