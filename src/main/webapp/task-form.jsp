<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Formulaire de Tache</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="my-4">${task != null ? 'Modifier la Tâche' : 'Créer une Nouvelle Tâche'}</h1>
    <form action="TaskServlet" method="post">
        <input type="hidden" name="action" value="${task != null ? 'editTask' : 'addTask'}">
        <input type="hidden" name="taskId" value="${task != null ? task.taskId : ''}">
        <input type="hidden" name="projectId" value="${projectId}">

        <div class="form-group">
            <label for="taskName">Nom de la Tache</label>
            <input type="text" class="form-control" id="taskName" name="taskName" value="${task != null ? task.taskName : ''}" required>
        </div>
        <div class="form-group">
            <label for="description">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required>${task != null ? task.description : ''}</textarea>
        </div>
        <div class="form-group">
            <label for="startDate">Date de Debut</label>
            <input type="date" class="form-control" id="startDate" name="startDate" value="${task != null ? task.startDate : ''}" required>
        </div>
        <div class="form-group">
            <label for="endDate">Date de Fin</label>
            <input type="date" class="form-control" id="endDate" name="endDate" value="${task != null ? task.endDate : ''}" required>
        </div>
        <div class="form-group">
            <label for="status">Statut</label>
            <select class="form-control" id="status" name="status" required>
                <option value="NOT_STARTED" <c:if test="${task != null && task.status eq 'NOT_STARTED'}">selected</c:if>>À faire</option>
                <option value="IN_PROGRESS" <c:if test="${task != null && task.status eq 'IN_PROGRESS'}">selected</c:if>>En cours</option>
                <option value="COMPLETED" <c:if test="${task != null && task.status eq 'COMPLETED'}">selected</c:if>>Termine</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">${task != null ? 'Mettre à Jour' : 'Creer'}</button>
    </form>
</div>
</body>
</html>
