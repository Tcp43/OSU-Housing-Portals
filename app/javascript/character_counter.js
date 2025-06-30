// File created 11/30/2024 by Yuxi Lin
// Dynamic count the remaining character that user allowed to put in a form that require text 

document.addEventListener('DOMContentLoaded', function () {
    const descriptionField = document.getElementById('description');
    const charCount = document.getElementById('char-count');
    const maxLength = descriptionField.getAttribute('maxlength');
  
    descriptionField.addEventListener('input', function () {
      const remaining = maxLength - descriptionField.value.length;
      charCount.textContent = `${remaining} characters remaining`;
    });
});