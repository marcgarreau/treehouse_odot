require 'spec_helper'
# require 'rails_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is what I'm doing."

		visit '/todo_lists'
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "readirects to the todo list index page on success" do
		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "displays an error when todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list(title: "", description: "This is what I'm doing.")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).not_to have_content("This is what I'm doing.")
	end

	it "displays an error when todo list has title less than three chars" do
		expect(TodoList.count).to eq(0)

		create_todo_list(title: "Hi", description: "This is what I'm doing.")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).not_to have_content("This is what I'm doing.")
	end

	it "displays an error when todo list has no description" do
		expect(TodoList.count).to eq(0)
		create_todo_list(title: "LOL", description: "")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).not_to have_content("This is what I'm doing.")
	end

	it "displays an error when todo list has description less than three chars" do
		expect(TodoList.count).to eq(0)
		create_todo_list(title: "LOL", description: "gg")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).not_to have_content("This is what I'm doing.")
	end
end