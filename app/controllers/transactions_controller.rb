class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: []

  # GET /transactions or /transactions.json
  def index
    items = Category.where(user_id: current_user.id)
    subcategories = Subcategory.where(:category_id => items)
    @transactions = Transaction.where(:subcategory_id => subcategories)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
   end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @subcategory = Subcategory.find(@transaction.subcategory_id)
    temp=@subcategory.remaining_budget - @transaction.amount
    if temp<0
      @transaction.errors.add(:base, "Budget exceeded!!")
      render :new
    else  
      @subcategory.update(remaining_budget: temp);
      respond_to do |format|
        if @transaction.save
          format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
          format.json { render :show, status: :created, location: @transaction }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    @transaction1 = Transaction.new(transaction_params);
    @transaction2 = Transaction.find(@transaction.id);
    @subcategory=Subcategory.find(@transaction2.subcategory_id);   
    temp=@subcategory.remaining_budget-@transaction1.amount+@transaction2.amount;
    @subcategory.update(remaining_budget: temp);
    
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction2 = Transaction.find(@transaction.id);
    @subcategory=Subcategory.find(@transaction2.subcategory_id);   
    temp=@subcategory.remaining_budget+@transaction2.amount;
    @subcategory.update(remaining_budget: temp);

    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:subcategory_id, :description, :amount, :img_url, :image)
    end
end
