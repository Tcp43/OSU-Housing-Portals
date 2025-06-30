/* Created by Kathir Maarikarthykeyan 11/24/2024: 
Created Toggle interactivity for drop down buttons and store values that are checked  */
document.querySelectorAll(".dropdown-container").forEach((dropdown) => {
  const selectButton = dropdown.querySelector(".select-btn");
  const items = dropdown.querySelectorAll(".item");

  // Toggle the dropdown menu for this specific dropdown
  selectButton.addEventListener("click", function () {
    selectButton.classList.toggle("open");
  });

  // Handle item selection for this specific dropdown
  items.forEach((item) => {
    item.addEventListener("click", function () {
      item.classList.toggle("checked");

      // Fetch all checked items within this dropdown
      const checkedItems = dropdown.querySelectorAll(".item.checked");

      // Get the text of all checked items
      const selectedTexts = Array.from(checkedItems).map(
        (checkedItem) => checkedItem.querySelector(".item-text").innerText
      );

      // Log the selected items for this dropdown
      console.log(
        `Selected items in dropdown (${
          selectButton.querySelector(".btn-txt").innerText
        }):`,
        selectedTexts.join(", ")
      );
    });
  });
});
