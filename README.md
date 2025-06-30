# Project-6-Rails-Rangers

## **OSU Off-Campus Housing Portal**

This project is an off-campus housing portal used to show connect OSU students and landlords more closely. It allows landlords to post listings and chat directly with interested students. Students can search and filter through listings, save listings that they are interested in, and chat with landlords.

## Known Bugs

- Pagination Bug

  - If you go on a later page within the student search section and then input another filter, then the page will appear to be blank. The pagination gem (kaminari) will update the amount of pages but does not switch the page back to the first new page of the filtered search. The website still works, but the user has to go down and physically click the "1" page on the pagination table.

## Presentation Slides

<https://docs.google.com/presentation/d/1Z-X2z--N-T_PY-NkDIIZMpK514RkKOWMxgVVAyja2xo/edit?usp=sharing>

## Execution Instructions

### Install Dependencies

Run the following command to install dependencies:

```bash
bundle install
```

### Set Up the Database

Create and migrate the SQLite database:

```bash
rails db:create
rails db:migrate
```

Seed the database with initial data:

```bash
rails db:seed
```

### Run the Rails Server

Start the Rails server with:

```bash
rails server
```

### Assign Yourself as an Admin

You can sign up and log in as student ot landlord.
To view the full functionality of the platform as an admin, follow these steps:

1. **Open the Rails console:**

    ```bash
    rails console
    ```

2. **Find your user record (replace `<your_email>` with your registered email address):**

    ```ruby
    user = User.find_by(email: '<your_email>')
    ```

3. **Update your role to admin:**

    ```ruby
    user.update(role: 'admin')
    ```

4. Exit the console:

    ```ruby
    exit
    ```

You are now assigned as an admin and can view and manage all functionalities of the platform.

### Run Tests

Run tests using:

```bash
rails db:test:prepare
```

then

```bash
rails test
```

### Stopping the Server

Stop the server by pressing `CTRL+C` in the terminal.

## Test Plan

We wrote a series of tests for each of our controllers and models used. Each can be found within test/controllers or test/models.

- ConversationsControllerTest

  - Handles tests related to the controller as it pertains to conversation creation and indexing.

- FavoritesControllerTest

  - Tests the functionality for adding and deleting a favorite to the user's favorites list.

- LandingControllerTest

  - Ensures that access to the different root/landing pages are done correctly depending on the user's role and authentication.

- ListingsControllerTest

  - Tests the creation, editing, and viewing of listings.

- MessagesControllerTest

  - Tests message creation and retrieval within a conversation.

- StudentSearchesControllerTest

  - Tests filtering when it comes to searching through listings

- UsersControllerTest

  - Makes sure that the correct profile page is retrieved depending on if the user is a landlord or student.

Each test file within test/models ensures the proper validation of the corresponding component within each model.
  
## Managers

- Manager Roles
  - Koury Harmon: Testing Manager
  - Yuxi Lin: Implementation Manager
  - Troy Paschal: Documentation Manager
  - Kathir Maarikarthykeyan: Overall Project Manager and Meeting Manager

## **Sprint #1**

### **Tasks for (Original/Didn’t Use) First Sprint Due: November 17th, 2024**

- **Koury Harmon**:
  - Design landing page for the portal including navbar, login buttons, profile icon.
  - Research how to send randomized verification codes for authentication for students.
  - Design sublease page where students can post properties they need to sublease.

- **Yuxi Lin**:
  - Design landlord view/page where landlords can post and view their property listings.
  - Implement backend logic for landlords to post new listings (house/apartment) and store in the database.

- **Troy Paschal**:
  - Design Student and Landlord profile pages including contact information.
  - Create a messaging interface for communication between students and landlord profile pages.

- **Kathir Maarikarthykeyan**:
  - Design Student view/page where students can post and view available property listings.
  - Implement backend logic for students to view new listings (house/apartment).

### **Tasks for (Revised) First Sprint Due: November 24th, 2024**

- **Koury Harmon**:
  - Design the landing page views (including pre-login and post-login for student and landlord).
  - Handle backend logic (including database) for adding/deleting listings.

- **Yuxi Lin**:
  - Design the login pages for students and landlords.
  - Handle backend logic for adding student and landlord user authentication for the login.

- **Troy Paschal**:
  - Design page for user and landlord profile sections.
  - Design chat and messages interface where users and landlords could message each other about listings.

- **Kathir Maarikarthykeyan**:
  - Design the Search/View homes page for students, displaying house cards and search/filter options.
  - Handle backend logic for creating search and filter elements.

---

## **Sprint #2 Due: November 29th, 2024**

- **Koury Harmon**:
  - Make new manage listings page for the landlord view.
  - Redesign the website layout (home page dashboard).

- **Troy Paschal**:
  - Handle student's favorite listings.
  - Allow students to message landlords in real time.
  - Add tests for controllers.

- **Yuxi Lin**:
  - Finish all views for routes generated by Devise.

- **Kathir Maarikarthykeyan**:
  - Make the filters and searching functionality work completely.
  - Scrape/populate the database with real OSU off-campus houses or listings.
  - Add tests.

---

## **Sprint #3 Due: December 1st, 2024**

- **Koury Harmon**:
  - Move the “post property” button to the My Listings page.
  - Handle spacing issues within the dashboard.

- **Troy Paschal**:
  - Enable deleting chats within the message portals.

- **Yuxi Lin**:
  - Change view and add customize style.

- **Kathir Maarikarthykeyan**:
  - Move the view listing and favorite functionality to the house search.
  - Populate the site with actual house images.

---

## **Sprint #4 Due: December 4th, 2024**

- **Finishing Tasks**:
  - Cover images for the house cards (**Kathir**).
  - Clear filters on the house search page (**Kathir**).
  - Populate all attributes in our listings (**Kathir**).
  - Add a delete chat button (**Koury**).
  - Add search filters for city and state (**Kathir**).
  - Fix prices to remove the `.0` (**Kathir**).
  - Add tests (**Everyone**).
  - Write documentation (**Everyone**).

## MVC and Rails contents

- Model
  
  - Active Record Migration Operations (create_table, add_column, add_index, etc.)
  - Associations (belongs_to, has_many, etc.)
    - Modifiers (foreign_key, dependent, etc.)
  - Validation (:presence, uniqueness, etc.)

- View

  - Partials
  - Embedded Ruby Functionality
  - Rails Helper Functions (form_with, link_to, button_to, etc.)
  - Bootstrap/Sass for styling

- Controller

  - render/redirect_to
  - :back
  - Flash Hash (:alert, :success, etc.)
  - RESTful route generation for Listing
  - Custom routes
  - Minitest/Fixtures for testing (default rails)

## Contributions

- Koury Harmon:
  - Set up rails skeleton
  - Implement dashboard and home pages
  - Implement view and functionality to examine a listing (show listing)
  - Created listing partial used in student favorites and landlord listing lists
  - Used Faker gem to seed initial user data
  - All corresponding tests

- Yuxi Lin:
  - Implement sessions control including user sign in, sign up, edit, delete, email confirmation
  - Implement view and functionality for user to post a new listing
  - Test for above

- Troy Paschal:
  - Implement controllers for users,conversations,favorites, and messages
  - Implement views for users,conversations,favorites, and messages
  - Test for above

- Kathir Maarikarthykeyan:
  - Implement controller for student search and filter functionality including pagination
  - Implement view for student search and filter functionality
  - Implemented ActiveStorage and image functionality for Houses on our website
  - Populated Database with real houses through CSV parsing
  - All corresponding tests
