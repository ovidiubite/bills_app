class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource
  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.all
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    respond_to do |format|
      if @bill.nil?
        format.html { redirect_to @bill, notice: 'Bill is empty' }
      else
        format.html { redirect_to bill_line_items_path(@bill), notice: 'Bill contains: ' }
      end
    end
  end

  # GET /bills/new
  def new
    authorize! :manage, Bill
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    authorize! :manage, Bill
    @bill = Bill.new(bill_params)
    @bill.author = current_user.email
    respond_to do |format|
      if @bill.save
        format.html { redirect_to new_bill_line_item_path(@bill), notice: 'Bill was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bills_path, notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    authorize! :manage, Bill
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url }
      format.json { head :no_content }
    end
  end

  def change_status
    @bill = Bill.find(params[:id])
    @bill.change_status('Paid')
    respond_to do |format|
      format.html { redirect_to bills_path, notice: 'Checkout successfully.' }
    end
  end

  def change_status_failed
    @bill = Bill.find(params[:id])
    @bill.change_status('Payment Failed')
    respond_to do |format|
      format.html { redirect_to bills_path, notice: 'Checkout Failed.' }
    end
  end

  def need_checkout
    @bills = Bill.all
    @bills_wait = @bills.where(status: 'Waiting')
    # @bills_proc = @bills.where(status: 'Processing')
    # @bills_proc.order('bills.updated_at DESC ')
    @bills_wait.order('bills.updated_at DESC ')
    # .map{|b| {id: b.id}}
    render json: @bills_wait.pluck(:id)
    if @bills_wait.any?
      if@bills_wait[0].status == 'Waiting'
        @bills_wait[0].status = 'Processing'
        @bills_wait[0].save
      end
    # elsif @bills_proc.any?
    #   @bills_proc.each do |bill|
    #     if bill.status == 'Processing'
    #       bill.status = 'Payment Failed'
    #       bill.save
    #     end
    #   end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill
    @bill = Bill.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bill_params
    params.require(:bill).permit(:name, :author, :limit_date, :status)
  end
end
