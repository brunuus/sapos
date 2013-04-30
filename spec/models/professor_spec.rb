require "spec_helper"

describe Professor do
  let(:professor) { Professor.new }
  subject { professor }
  describe "Validations" do
    describe "cpf" do
      context "should be valid when" do
        it "cpf is not null and is not taken" do
          professor.cpf = "Professor cpf"
          professor.should have(0).errors_on :cpf
        end
      end
      context "should have error blank when" do
        it "cpf is null" do
          professor.cpf = nil
          professor.should have_error(:blank).on :cpf
        end
      end
      context "should have error taken when" do
        it "cpf is already in use" do
          cpf = "Professor cpf"
          FactoryGirl.create(:professor, :cpf => cpf)
          professor.cpf = cpf
          professor.should have_error(:taken).on :cpf
        end
      end
    end
    describe "name" do
      context "should be valid when" do
        it "name is not null and is not taken" do
          professor.name = "Professor name"
          professor.should have(0).errors_on :name
        end
      end
      context "should have error blank when" do
        it "name is null" do
          professor.name = nil
          professor.should have_error(:blank).on :name
        end
      end
    end
  end
  describe "Methods" do
    describe "advisement_points" do
      it "should return 0 if the professor has no advisement_authorizations" do
        professor.advisement_points.should eql("0.0")
      end
      it "should return the spected number if the professor has advisement_authorizations" do
        professor = FactoryGirl.create(:professor)
        other_professor = FactoryGirl.create(:professor)
        enrollment = FactoryGirl.create(:enrollment)
        other_enrollment = FactoryGirl.create(:enrollment, :level => enrollment.level)

        FactoryGirl.create(:advisement_authorization, :professor => professor, :level => enrollment.level)
        FactoryGirl.create(:advisement_authorization, :professor => other_professor, :level => enrollment.level)

        FactoryGirl.create(:advisement, :professor => professor, :enrollment => enrollment)
        FactoryGirl.create(:advisement, :professor => professor, :enrollment => other_enrollment)

        FactoryGirl.create(:advisement, :professor => other_professor, :enrollment => other_enrollment, :main_advisor => false)

        professor.advisement_points.should eql("1.5")
      end
    end
    describe "advisement_point" do
      context "should return 0 when" do
        it "the professor has no advisement_authorizations" do
          enrollment = FactoryGirl.create(:enrollment)
          professor.advisement_point(enrollment).should eql(0.0)
        end
        it "the enrollment is not advised by the professor" do
          professor = FactoryGirl.create(:professor)
          other_professor = FactoryGirl.create(:professor)
          enrollment = FactoryGirl.create(:enrollment)
          FactoryGirl.create(:advisement_authorization, :professor => professor, :level => enrollment.level)
          FactoryGirl.create(:advisement_authorization, :professor => other_professor, :level => enrollment.level)
          FactoryGirl.create(:advisement, :professor => other_professor, :enrollment => enrollment)

          professor.advisement_point(enrollment).should eql(0.0)
        end
        it "the enrollment have a dismissal" do
          professor = FactoryGirl.create(:professor)
          enrollment = FactoryGirl.create(:enrollment)
          FactoryGirl.create(:advisement_authorization, :professor => professor, :level => enrollment.level)
          FactoryGirl.create(:advisement, :professor => professor, :enrollment => enrollment)
          FactoryGirl.create(:dismissal, :enrollment => enrollment)

          professor.advisement_point(enrollment).should eql(0.0)
        end
      end
      it "should return 1 when the professor is the only authorized advisor" do

        professor = FactoryGirl.create(:professor)
        other_professor = FactoryGirl.create(:professor)
        enrollment = FactoryGirl.create(:enrollment)

        FactoryGirl.create(:advisement_authorization, :professor => professor, :level => enrollment.level)

        FactoryGirl.create(:advisement, :professor => professor, :enrollment => enrollment)
        FactoryGirl.create(:advisement, :professor => other_professor, :enrollment => enrollment, :main_advisor => false)

        professor.advisement_point(enrollment).should eql(1.0)
      end
      it "should return 1 when the professor is not the only authorized advisor" do
        professor = FactoryGirl.create(:professor)
        other_professor = FactoryGirl.create(:professor)
        enrollment = FactoryGirl.create(:enrollment)

        FactoryGirl.create(:advisement_authorization, :professor => professor, :level => enrollment.level)
        FactoryGirl.create(:advisement_authorization, :professor => other_professor, :level => enrollment.level)

        FactoryGirl.create(:advisement, :professor => professor, :enrollment => enrollment)
        FactoryGirl.create(:advisement, :professor => other_professor, :enrollment => enrollment, :main_advisor => false)

        professor.advisement_point(enrollment).should eql(0.5)
      end
    end
  end
end