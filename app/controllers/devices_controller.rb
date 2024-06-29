class DevicesController < ApplicationController
    
    def index

        if params[:query].present?
            query = "%#{params[:query]}%"
            @all_device = Device.where("CAST(id AS TEXT) ILIKE ? ", query)
        else
            @all_device = Device.all
        end
    end

    def new
        @device = Device.new
    end

    def show
        if params[:id].present?
            @device = Device.find_by(id: params[:id])
        else
            @device = Device.all
        end
    end

    def search
        if params[:query].present?
            @device = Device.find_by(id: params[:query])
        else
            @device = Device.all
        end
    end

    def edit
        get_device
    end

    def create
        create_device = Device.new(params_device)

        if create_device.save
            redirect_to devices_path, notice: "Dispositivo registrado correctamente!!."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        if get_device.update(params_device)
            redirect_to devices_path, notice: "Dispositivo modificado correctamente!!."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if get_device.destroy
            redirect_to devices_path, notice: "Dispositivo eliminado correctamente!!."
        else
            render :index, status: :unprocessable_entity
        end
    end

    private

    def get_device
        @device = Device.find(params[:id])
    end

    def params_device
        params.require(:device).permit(:id, :bodega, :local, :factor)
    end
end
