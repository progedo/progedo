require 'rails_helper'

RSpec.describe Survey, type: :model do


	context '.create!' do

		it "has one more after adding one" do
			num = Survey.count
			Survey.create
			expect(Survey.count).to eq(num + 1)
		end

		it 'creates survey with empty fields' do
			survey = Survey.create!
			expect(survey.title).to be_nil
			expect(survey.abstract).to be_nil
		end

		it 'has same survey title' do
			survey = Survey.create(title: "Title", abstract: "Abstract")
			survey_bis = Survey.find_by(abstract: "Abstract")
			expect(survey_bis.title).to eq survey.title
		end

		it 'has same survey abstract' do
			survey = Survey.create(title: "Title", abstract: "Abstract")
			survey_bis = Survey.find_by(title: "Title")
			expect(survey_bis.abstract).to eq survey.abstract
		end

	end
  


	context 'associations' do
		it { should have_one(:fichier) }
	end

	context 'attributes' do

		context 'title' do
			it { should have_db_column(:title).of_type(:string).with_options(null: true) }
		end

		context 'abstract' do
			it { should have_db_column(:abstract).of_type(:text).with_options(null: true) }
		end
	end

	context "adding fichier" do
		it "get one fichier" do
			survey = Survey.create
			fichier1 = Fichier.create(chemin: "first fichier")
			survey.fichier = fichier1
			expect(survey.fichier).to eq(fichier1)
		end
	end

	context "delete survey" do

		it "loses one after one has been deleted" do
			num = Survey.count
			survey = Survey.create
			expect(Survey.count).to eq(num + 1)
			survey.destroy
			expect(Survey.count).to eq(num)
		end

		it "has its file which persists after its deletion" do
			survey = Survey.create
			fichier1 = Fichier.create(chemin: "first_fichier")
			survey.fichier = fichier1
			survey.destroy
			expect(fichier1.id).to eq(Fichier.find_by(chemin: "first_fichier").id)
		end

	end

	context "update survey" do
		it "has its title or abstract changing but not its id" do
			survey = Survey.create(title: "Title", abstract: "Abstract")
			survey_bis = Survey.find_by(abstract: "Abstract")
			survey.update title: "Another Title", abstract: "Another Abstract"
			expect(survey_bis.title).not_to eq survey.title
			expect(survey_bis.abstract).not_to eq survey.abstract
			expect(survey_bis.id).to eq survey.id
		end
	end
end