Feature: add, edit, delete movies

  As a movie buff
  So that I can add, edit and delete movies
  I want to add my movie, edit or delete the existing movies.

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: creating a new movie
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  And I fill in "Title" with "300"
  And I select "R" from "Rating"
  And I select "2014" from "movie_release_date_1i"
  And I select "May" from "movie_release_date_2i"
  And I select "5" from "movie_release_date_3i"
  And I press "Save Changes"
  Then I should see "300 was successfully created."


Scenario: deleting an existing movie
  Given I am on the home page
  When I follow "Add new movie"
  And I fill in "Title" with "Mission Impossible"
  And I select "PG" from "Rating"
  And I press "Save Changes"
  When I follow "More about Mission Impossible"
  And I press "Delete"
  And I should see "Movie 'Mission Impossible' deleted."

Scenario: editing an existing movie
  Given I am on the home page
  When I follow "More about Alien"
  And I follow "Edit"
  And I fill in "Director" with "Ruby"
  And I press "Update Movie Info"
  And I should see "Alien was successfully updated"

Scenario: returning to home page
  Given I am on the details page for "Star Wars"
  When I follow "Back to movie list"
  And I should be on the home page


