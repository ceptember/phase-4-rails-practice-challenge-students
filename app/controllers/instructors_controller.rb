class InstructorsController < ApplicationController
   
    def index
        instructors = Instructor.all
        render json: instructors 
    end

    def show
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            render json: instructor 
        else
          render json: {error: "not found"}
        end 
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created 
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor 
            instructor.update!(instructor_params)
     
        render json: instructor
        else 
            render json: {error: "not found"}
        end 
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end


    def destroy
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            render json: {} 
        else
            render json: {error: "not found"}
        end 
    end 

    private

    def instructor_params
        params.permit(:name)
    end


    

end
