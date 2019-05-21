require 'rails_helper'

RSpec.describe Fichier, type: :model do
 context '.create!' do

		it "has one more after adding one" do
			num = Fichier.count
			survey = Survey.create(title: "Title", abstract: "Abstract")
			Fichier.create(survey_id: survey.id)
			expect(Fichier.count).to eq(num + 1)
		end

		it "must have survey_id" do
			expect {Fichier.create!}.to  raise_error(ActiveRecord::RecordInvalid)
		end

		it 'creates fichier with empty fields' do
			survey = Survey.create(title: "Title", abstract: "Abstract")
			fichier = Fichier.create(survey_id: survey.id)
			expect(fichier.chemin).to be_nil
		end

		it 'has same survey chemin' do
			survey = Survey.create(title: "Title", abstract: "Abstract")
			fichier = Fichier.create(chemin: "Chemin", survey_id: survey.id)
			fichier_bis = Fichier.all.last
			expect(fichier_bis.chemin).to eq fichier.chemin
		end

	end

	context 'associations' do
		it { should have_and_belong_to_many :requests }
		it { should belong_to :survey }
	end

	context 'attributes' do
		context 'chemin' do
			it { should have_db_column(:chemin).of_type(:string).with_options(null: true) }
		end
	end

	context "delete fichier" do

		it "loses one after one has been deleted" do
			num = Fichier.count
			survey = Survey.create(title: "Title", abstract: "Abstract")
			fichier = Fichier.create(survey_id: survey.id)
			expect(Fichier.count).to eq(num + 1)
			fichier.destroy
			expect(Fichier.count).to eq(num)
		end

		it "has its survey which persists after its deletion" do
			survey = Survey.create(title: "Title", abstract: "Abstract")
			fichier = Fichier.create(chemin: "first_fichier", survey_id: survey.id)
			survey.destroy
			expect(fichier.id).to eq(Fichier.find_by(chemin: "first_fichier").id)
		end

	end

	context "update fichier" do
		it "has its chemin changing but not its id" do
			survey = Survey.create(title: "Title", abstract: "Abstract")
			survey2 = Survey.create(title: "Title2", abstract: "Abstract2")
			fichier = Fichier.create(chemin: "Chemin", survey_id: survey.id)
			fichier_bis = Fichier.find_by(chemin: "Chemin")
			fichier.update chemin: "Another Chemin", survey_id: survey2.id
			expect(fichier_bis.chemin).not_to eq fichier.chemin
			expect(fichier_bis.survey_id).not_to eq fichier.survey_id
			expect(fichier_bis.id).to eq fichier.id
		end
	end

end
