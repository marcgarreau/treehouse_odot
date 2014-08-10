require 'spec_helper'

describe "Editing todo lists" do
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.")}

	def update_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is what I'm doing."

		todo_list = options[:todo_list]

		visit '/todo_lists'
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: "New title"
		fill_in "Description", with: "New description"
		click_button "Update Todo list"
	end

	it "updates a todo list successfully" do
		update_todo_list(todo_list: todo_list, 
										 title: "New title", 
										 description: "New description")

		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq("New description")
	end

end