class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        
        format.html { redirect_to @client, notice: 'Thank you! You will receive an SMS shortly with verification instructions.Client was successfully created.' }
        # format.json { render :show, status: :created, location: @client }

        # put your own credentials here 
        account_sid = 'AC34e7de487e02d9568647b04982519563' 
        auth_token = '607bddc0804b3c0f447c09b44b7bc28f' 
 
        # set up a client to talk to the Twilio REST API 
        @user = Twilio::REST::Client.new account_sid, auth_token 
 
        @user.account.messages.create({
          :from => '+12018172417',  
          :to => "+91" + @client.phone,
          :body => @client.email,
          # :media_url => "http://twilio.com/heart.jpg"
        })

        @user.account.calls.create({
          :from => '+12018172417',  
          :to => "+91" + @client.phone,
          url: 'http://example.com/call-handler'
          # :media_url => "http://twilio.com/heart.jpg"
        })

        


        #  # Instantiate a Twilio client
        # user = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
        # # Create and send an SMS message
        # user.account.sms.messages.create(
        # from: TWILIO_CONFIG['from'],
        # to: @client.phone,
        # body: "Thanks for signing up. To verify your account, please reply HELLO to this message."
        #  ) 


      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :phone, :verified)
    end
end
