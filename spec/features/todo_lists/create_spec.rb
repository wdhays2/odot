require 'spec_helper'

describe "Creating todo lists" do
	it "redirects to the todo list index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo list")

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today"
		click_button "Create Todo list"

		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo list")

		fill_in "Title", with: "hello there"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.") 
	end

	it "displays an error when the todo list has a title less than 3 characters" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo list")

		fill_in "Title", with: "Hello"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.") 
	end

end