class LecturasController < ApplicationController
    
    def index
        @Lectura = Lectura.find_by(id: params[:search])
    end

    def new
        @Lectura = Lectura.new
    end

    def show
        get_lectura
    end

    def edit
        get_lectura
    end

    def create
        @Lectura = Lectura.new(params_lectura)

        if @Lectura.save
            redirect_to lecturas_path, notice: "El registro fue creado correctamente!!."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        consumo = (params[:lectura_actual].to_i-get_lectura.lectura_anterior.to_i)*get_lectura.factor.to_i
        if get_lectura.update(params_lectura.merge(consumo: consumo))
            redirect_to lecturas_path, notice: "El registro fue actualizado correctamente!!."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def get_lectura
        @Lectura = Lectura.find(params[:id])
    end

    def params_lectura
        params.require(:lectura).permit(:bodega, :local, :factor, :lectura_anterior, :lectura_actual)
    end
end
