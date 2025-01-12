import Rails from "@rails/ujs";
Rails.start();
console.log("Rails UJS loaded");

console.log("Turbo is being loaded...");
import "@hotwired/turbo-rails";
console.log("Turbo was loaded successfully.");

// Correct the import path for controllers
import "./controllers";

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".delete-post").forEach(button => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      if (confirm("Are you sure you want to delete this post?")) {
        const postId = button.getAttribute("data-post_id");
        fetch(`/posts/${postId}`, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
            "Content-Type": "application/json"
          }
        })
        .then(response => {
          if (response.ok) {
            window.location.reload();
          } else {
            alert("Failed to delete the post.");
          }
        })
        .catch(error => {
          console.error("Error:", error);
          alert("Failed to delete the post.");
        });
      }
    });
  });
});
