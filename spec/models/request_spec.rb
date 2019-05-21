require 'rails_helper'

RSpec.describe Request, type: :model do

	context '.create!' do

		it "has one more after adding one" do
			num = Request.count
			user = User.create!(email: "user@example.org", password: "very-secret")
			Request.create(user_id: user.id)
			expect(Request.count).to eq(num + 1)
		end

		it 'creates request with empty fields' do
			user = User.create!(email: "user@example.org", password: "very-secret")
			request = Request.create(user_id: user.id)
			expect(request.title).to be_nil
			expect(request.description).to be_nil
		end

		it 'has same request title' do
			user = User.create!(email: "user@example.org", password: "very-secret")
			request = Request.create(title: "Title", description: "Description", user_id: user.id)
			request_bis = Request.find_by(description: "Description")
			expect(request_bis.title).to eq request.title
		end

		it 'has same request description' do
			user = User.create!(email: "user@example.org", password: "very-secret")
			request = Request.create(title: "Title", description: "Description", user_id: user.id)
			request_bis = Request.find_by(title: "Title")
			expect(request_bis.description).to eq request.description
		end

	end

	context 'associations' do
		it { should have_and_belong_to_many :fichiers }
		it { should belong_to :user }
	end

	context 'attributes' do

		context 'title' do
			it { should have_db_column(:title).of_type(:string).with_options(null: true) }
		end

		context 'description' do
			it { should have_db_column(:description).of_type(:text).with_options(null: true) }
		end
	end

	context "adding fichier" do
		it "get two fichier" do
			fichier1 = Fichier.create(chemin: "first fichier", survey_id: Survey.create.id)
			fichier2 = Fichier.create(chemin: "second fichier", survey_id: Survey.create.id)			
			user = User.create!(email: "user@example.org", password: "very-secret")
			request = Request.create(user_id: user.id)
			request.fichiers << fichier1
			request.fichiers << fichier2
			expect(request.fichiers).to eq([fichier1, fichier2])
		end
	end

	context "delete request" do

		it "loses one after one has been deleted" do
			num = Request.count
			user = User.create!(email: "user@example.org", password: "very-secret")
			request = Request.create(user_id: user.id)
			expect(Request.count).to eq(num + 1)
			request.destroy
			expect(Request.count).to eq(num)
		end

		it "has its file which persists after its deletion" do
			user = User.create!(email: "user@example.org", password: "very-secret")
			request = Request.create(user_id: user.id)
			fichier1 = Fichier.create(chemin: "first_fichier", survey_id: Survey.create.id)
			request.fichiers << fichier1
			request.destroy
			expect(fichier1.id).to eq(Fichier.find_by(chemin: "first_fichier").id)
		end

	end

	context "update request" do
		it "has its title or description changing but not its id" do
			user = User.create!(email: "user@example.org", password: "very-secret")
			request = Request.create(title: "Title", description: "Description", user_id: user.id)
			request_bis = Request.find_by(description: "Description")
			request.update title: "Another Title", description: "Another Description"
			expect(request_bis.title).not_to eq request.title
			expect(request_bis.description).not_to eq request.description
			expect(request_bis.id).to eq request.id
		end
	end

end
