class Persona {
  var property formaDePago = []
  var property pagoPreferido
  var property dinero
  var property salario
  var property salarioDelMes = salario
  var totalCuotasImpagas = 0
  const cantCosas = []
  var property mayorComprador

  method cambiarPagoPreferida(formPago) {
    pagoPreferido = formPago
  }

  method comprar(monto) {
    if(pagoPreferido.sePuedeUsar()){
    pagoPreferido.hacerLaCompra(self,monto)
    cantCosas.add("producto") }
    else 
    self.error("No se acepta la forma de pago seleccionada")
  }

  method aumentarSalario(aumento) {
    salario += aumento
  }

  method terminarMes() {
    self.pagarCuotaDeMes()
    self.cobrarSalario()
  }

  method pagarCuotaDeMes() {
    if (Credito.cuotasPorPagar != 0){
      if(salario>=Credito.valorCuota) {
    salarioDelMes -= Credito.valorCuota
    Credito.restarCuotasPorPagar()
    }
    else {
      self.error("La persona no puede pagar la cuota este mes")
      totalCuotasImpagas += Credito.valorCuota
    }
    }
    else{
    self.error("La persona no tiene cuotas que pagar")
    }

  }

  method mostrarTotalCuotasImpagas() = totalCuotasImpagas

  method cobrarSalario() {
    dinero += salarioDelMes
    salarioDelMes = salario
  }

  method gastar(monto) {
    dinero -= monto
  } 

  method PersonaQueMasTiene() {
  //mayorComprador = cantCosas.max()
}
}

class FormaDePago {
  var property sePuedeUsar 
}

class Efectivo inherits FormaDePago {
  method hacerLaCompra(persona,monto) {
    if (persona.dinero()>=monto){
      persona.gastar(monto)
    }
  else self.error("el dinero de la persona no es suficiente")
  }
}
class Debito inherits FormaDePago {
  var property saldo 
  method hacerLaCompra(persona,monto) {
    if (saldo>=monto){
      persona.gastarSaldo(monto)
    }
  else self.error("el dinero de la persona no es suficiente")  
  }

  method gastarSaldo(monto) {
    saldo -= monto
  } 
}


class Credito inherits FormaDePago {
var property maximoPermitido
const cuotasPorMesTarjeta 
var property cuotasPorPagar
var valorCuota = 0

  method hacerLaCompra(persona,monto) {
    if (maximoPermitido>=monto){
      self.agregarCuotas(monto)
    }
    else self.error("el monto supera a lo maximo permitido por el banco")
  }

  method agregarCuotas(monto) {
   valorCuota = monto/cuotasPorMesTarjeta + bancoCentral.interes()
   cuotasPorPagar = cuotasPorMesTarjeta 
  }

  method restarCuotasPorPagar() {
  cuotasPorPagar -= 1
  }
}

object bancoCentral {
  var interes = 200
  method interes() = interes
  method cambiarInteres(nuevo) {
    interes = nuevo 
  }
}

class PrestamoSinInteres inherits Credito {
override method agregarCuotas(monto) {
   valorCuota = monto/cuotasPorMesTarjeta
   cuotasPorPagar = cuotasPorMesTarjeta 
  }
}

//------------------------- Segunda Parte --------------------------------

class CompradoresCompulsivos inherits Persona {
  var property formasDePagoDisponible = []
  override method comprar(monto) {
    if(pagoPreferido.sePuedeUsar()){
    pagoPreferido.hacerLaCompra(self,monto)
    cantCosas.add("producto") }
    else 
    //pagoPreferido()
  }
}

class PagadoresCompulsivos inherits Persona {
  override method pagarCuotaDeMes() {
    if (Credito.cuotasPorPagar != 0){
    salarioDelMes -= Credito.valorCuota
    if (salarioDelMes<0 and dinero > -salarioDelMes) {
      dinero +=salarioDelMes
    }
    else {}
    Credito.restarCuotasPorPagar()
    }
    else{
    self.error("La persona no tiene cuotas que pagar")
    }

  }
}






