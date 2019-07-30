document.addEventListener("DOMContentLoaded", function() {
  document
    .getElementById("add-entry-button")
    .addEventListener("click", function(event) {
      let newEntryField = document
        .getElementById("entry-template")
        .content.cloneNode(true);
      document.getElementById("entries-area").appendChild(newEntryField);
    });
  document
    .getElementById("entries-area")
    .addEventListener("click", function(e) {
      if (e.target && e.target.classList.contains("remove-entry-button")) {
        e.target.parentElement.remove();
      }
    });

  document
    .getElementById("add-user-button")
    .addEventListener("click", function(event) {
      let newUserField = document
        .getElementById("user-template")
        .content.cloneNode(true);
      document.getElementById("users-area").appendChild(newUserField);
    });
  document.getElementById("users-area").addEventListener("click", function(e) {
    if (e.target && e.target.classList.contains("remove-user-button")) {
      e.target.parentElement.remove();
    }
  });
});
