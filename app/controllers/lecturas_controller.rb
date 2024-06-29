class LecturasController < ApplicationController
    
    def index
        @Lectura = Lectura.find_by(id: params[:search])
    end

    def list_ids
        if params[:query].present?
            query = "%#{params[:query]}%"
            @Lecturas = Lectura.where("CAST(lectura_actual AS TEXT) ILIKE ? OR CAST(device_id AS TEXT) ILIKE ? ", query, query)
        else
            @Lecturas = Lectura.all
        end
    end

    def new 
        @lectura = Lectura.new
    end

    def show
        get_lectura
    end

    def edit
        get_lectura
    end

    def create
        @lectura = Lectura.new(params_lectura)
        if @lectura.save

            lectura_device = Lectura.where(device_id: params_lectura[:device_id]).order(created_at: :desc)
            last = lectura_device.second
            if lectura_device.count > 1 && last.present?
                @lectura.update(lectura_anterior: last.lectura_actual)
            end

            redirect_to root_path, notice: "Lectura registrada correctamente!!."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        consumo = (params[:lectura_actual].to_i-get_lectura.lectura_anterior.to_i)*get_lectura.factor.to_i
        if !params[:lectura_actual].blank?
            if get_lectura.update(params_lectura.merge(consumo: consumo))
                redirect_to lecturas_path, notice: "El registro fue actualizado correctamente!!."
            else
                render :edit, status: :unprocessable_entity
            end
        else
            @Lectura = Lectura.new(params_lectura)
            if @Lectura.save
                redirect_to lecturas_path, notice: "El registro fue actualizado correctamente!!."
            else
                render :edit, status: :unprocessable_entity
            end
        end
    end

    private

    def get_lectura
        @Lectura = Lectura.find(params[:id])
    end

    def params_lectura
        params.require(:lectura).permit(:lectura_actual, :device_id)
    end
end
