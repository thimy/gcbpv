class Users::StudentsController < BaseController
  before_action :set_student, only: %i[ show edit update destroy ]
  before_action :set_household, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @students = Student.where(household_id: current_user.household_id)
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to user_student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to user_student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to user_students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    def set_household
      @household = Household.find(current_user.household_id)
    end

    # Only allow a list of trusted parameters through.
    def student_params
      if params[:is_household] == "yes"
        params[:student][:first_name] = @household.first_name
        params[:student][:last_name] = @household.last_name
        reset_address_params
      elsif params[:household_address] == "yes"
        reset_address_params
      end
      params.require(:student).permit(:first_name, :last_name, :birth_year, :gender, :phone, :email, :address, :postcode, :city)
    end

    def reset_address_params
      params[:student][:phone] = nil
      params[:student][:email] = nil
      params[:student][:address] = nil
      params[:student][:postcode] = nil
      params[:student][:city] = nil
    end
end
