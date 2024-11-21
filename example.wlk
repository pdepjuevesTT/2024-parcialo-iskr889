class Persona {
  var property formaDePago = []
  var property pagoPreferido
  var property dinero
  var property salario
  var property salarioDelMes = salario


  method cambiarPagoPreferida(formPago) {
    pagoPreferido = formPago
  }

  method comprar(monto) {
    pagoPreferido.hacerLaCompra(self,monto)
  }

  method aumentarSalario(aumento) {
    salario += aumento
  }

  method terminarMes(cuotaMes) {
    self.pagarCuotaDeMes()
    self.cobrarSalario()
  }

  method pagarCuotaDeMes() {
    if (salarioDelMes>= Credito.cuotaMes)
    salarioDelMes -= Credito.cuotaMes
    else
    self.error("La persona no puede pagar la cuota del mes")
  }

  method cobrarSalario() {
    dinero += salarioDelMes
    salarioDelMes = salario
  }

  method gastar(monto) {
    dinero -= monto
  } 
}

object efectivo {
  method hacerLaCompra(persona,monto) {
    if (persona.dinero()>=monto){
      persona.gastar(monto)
    }
  else self.error("el dinero de la persona no es suficiente")
  }
}
class Debito {
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


class Credito {
var property maximoPermitido
const cuotasPorMesTarjeta = []
var cuotaMes = 0

  method hacerLaCompra(persona,monto) {
    if (maximoPermitido>=monto){
      self.agregarCuotas(monto)
    }
    else self.error("el monto supera a lo maximo permitido por el banco")
  }

  method agregarCuotas(monto) {
   cuotaMes = monto/cuotasPorMesTarjeta.size() + BancoCentral.interes()
  }
}

class BancoCentral {
  var property interes
  method interes() = interes
}

