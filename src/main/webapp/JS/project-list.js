
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
