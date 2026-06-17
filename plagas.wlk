class Elemento{
    method esBueno()
    method recibirAtaque(unaPlaga)
}
class Hogar inherits Elemento{
    var property nivelDeMugre
    var property confortQueOfrece
    override method esBueno(){
        return nivelDeMugre <= (confortQueOfrece/2)
    }
    override method recibirAtaque(unaPlaga){
        nivelDeMugre += unaPlaga.nivelDeDaño()
    }
}
class Huerta inherits Elemento{
    var property capacidadDeProduccion
    const nivelMinimo = 100
    override method esBueno(){
        return self.capacidadDeProduccion() > nivelMinimo
    }
    override method recibirAtaque(unaPlaga){
        capacidadDeProduccion -= unaPlaga.nivelDeDaño() * 0.1
        if (unaPlaga.transmitirEnfermedades()){
            capacidadDeProduccion -= 10
        }
    }
}
class Mascota inherits Elemento{
    var property nivelDeSalud 
    override method esBueno(){
        return nivelDeSalud > 250
    }
    override method recibirAtaque(unaPlaga){
        if (unaPlaga.transmitirEnfermedades()){
            nivelDeSalud -= unaPlaga.nivelDeDaño()
        }
    }
}   
class Barrio{
    const property elementos
    method esCopado(){
        return elementos.count({e=>e.esBueno()})>
        elementos.count({e=>!e.esBueno()})
    }
}

//plagas
class Plaga{
    var property poblacion
    method nivelDeDaño()

    method transmitirEnfermedades()= poblacion >= 10
    method atacar(unElemento){
        self.efectosDeAtaque()
        unElemento.recibirAtaque(self)
    }
    method efectosDeAtaque(){
        poblacion *= 1.1
    }
}
class Cucaracha inherits Plaga{
    var property pesoPromedio 
    override method nivelDeDaño(){
        return poblacion / 2
    }
    override method transmitirEnfermedades(){
       return super().transmitirEnfermedades() && pesoPromedio >= 10
    }
    override method efectosDeAtaque(){
        super().efectosDeAtaque() 
        pesoPromedio += 2
    }
}
class Pulga inherits Plaga{
    override method nivelDeDaño(){
        return poblacion * 2
    }
}
class Garrapata inherits Pulga{
   override method efectosDeAtaque(){
        poblacion *= 1.2
    }
}
class Mosquito inherits Pulga{
    override method nivelDeDaño(){
        return poblacion
    }
    override method transmitirEnfermedades(){
        return super().transmitirEnfermedades() && poblacion % 3 == 0
    }
}