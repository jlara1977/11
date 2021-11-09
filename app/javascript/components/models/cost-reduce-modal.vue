<template>
  <div class="flex flex-col mx-5 my-3 font-main">
    <button
      class="self-end mb-2 focus:outline-none"
      @click="closeModal"
    >
      <img
        class="w-6 h-6"
        :src="require('assets/images/close.svg')"
      >
    </button>
    <p class="mb-6 text-sm font-medium md:text-lg">
      Te presentamos dos maneras con las que puedes disminuir tu cuota mensual:
    </p>
    <div class="flex flex-col px-5 py-2 mb-4 border rounded-md lg:rouded-lg">
      <span class="text-xs font-medium text-nexcar-green">Opción 1</span>
      <div class="flex flex-col md:flex-row">
        <div class="flex flex-col mb-3 md:w-1/3 md:mb-0">
          <span class="inline-block mb-3 text-sm font-medium text-gray-700 md:text-base md:mb-0">Anticipo Inicial</span>
          <div class="h-0.5 border-nexcar-green border-t-2 w-11" />
        </div>
        <p class="text-xs text-gray-700 md:w-2/3">
          Entregas un monto como adelanto, el cual reduce considerablemente las cuotas a pagar a futuro.
        </p>
      </div>
    </div>
    <div class="flex flex-col px-5 py-2 mb-6 border rounded-md md:mb-8 lg:rouded-lg">
      <span class="text-xs font-medium text-nexcar-green">Opción 2</span>
      <div class="flex flex-col md:flex-row">
        <div class="flex flex-col mb-3 md:w-1/3 md:mb-0">
          <span class="inline-block mb-3 text-sm font-medium text-gray-700 md:text-base md:mb-0">Cofinanciamiento</span>
          <div class="h-0.5 border-nexcar-green border-t-2 w-11" />
        </div>
        <p class="text-xs text-gray-700 md:w-2/3">
          Entregas un monto donde estás co-invirtiendo, el cual será devuelto completamente al final del contrato en UF.
          Este monto va a generar intereses de UF + 5% los cuales se irán descontando mes a mes de la cuota.
          El cofinanciamiento funciona finalmente como un préstamo o inversión en Nexcar, donde la cuota se reduce en
          menor medida que con anticipo inicial, ya que son sólo los intereses que va generando tu monto los que se van
          descontando de la cuota.
        </p>
      </div>
    </div>
    <div
      class="h-0.5 border-t border-gray-200 mb-6"
      v-if="!this.$root.isMobile"
    />
    <p class="mb-6 text-xs text-gray-700 md:text-sm">
      Para que te quede más claro te dejamos un ejemplo:
    </p>
    <p class="mb-3 text-xs text-gray-700 md:text-sm md:mb-6">
      Supongamos que vas a contratar un
      <span class="font-semibold text-nexcar-green">
        Suzuki Swift 2021, plazo 24 meses con 12.000 kilómetros al año.
      </span>
    </p>
    <div class="flex flex-col px-2 py-2 mb-3 md:px-5 bg-nexcar-second-light-green bg-opacity-80 md:mx-12">
      <p class="self-end w-1/2 mb-2 text-right text-gray-700 text-xxs md:text-xs md:text-center">
        Cuota mensual a pagar
      </p>
      <div class="flex text-gray-700 text-xxs md:text-xs">
        <div class="grid w-1/2 grid-cols-1 pr-2 border-r-2 border-nexcar-green gap-y-1">
          <span>Sin anticipo ni cofinanciamiento</span>
          <span>Anticipo inicial de $3.000.000</span>
          <span>Cofinanciamiento de $3.000.000</span>
        </div>
        <div class="grid w-1/2 grid-cols-1 font-medium text-right md:text-center">
          <span>$ 262.000</span>
          <span>$ 134.000</span>
          <span>$ 249.000</span>
        </div>
      </div>
    </div>
    <p class="mb-10 text-gray-700 text-xxs">
      <span class="font-semibold text-nexcar-green">*</span>
      En la opción del cofinanciamiento te devolveremos los $3.000.000 en UF al final del contrato.
    </p>
    <div class="flex items-center justify-between">
      <p class="text-gray-700 text-xxs md:text-sm">
        Si tienes más dudas, escríbenos a <span class="underline text-nexcar-green">contacto@nexcar.cl</span>
      </p>
      <button
        class="flex justify-center p-1 text-white rounded-md bg-nexcar-green place-items-center"
        @click="closeModal"
      >
        ¡Listo!
      </button>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    closeModal() {
      this.$modal.hide('cost-reduce-modal');
    },
  },
};
</script>
