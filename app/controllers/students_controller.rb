class StudentsController < ApplicationController

    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find_by(id: params[:id])
        render json: student 
    end 

    def create
        student = Student.create!(student_params)
        render json: student, status: :created 
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        student = Student.find_by(id: params[:id])
        if student
            student.update!(student_params)
            render json: student 
        else
            render json: {error: "not found"}, status: :not_found
        end
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity

    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student 
            student.destroy
            render json: {}
        else 
            render json: {error: "not found"}, status: :not_found
        end 
    end 

    private

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end
end
