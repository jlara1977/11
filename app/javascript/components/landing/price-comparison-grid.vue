<template>
  <div class="flex flex-col text-gray-700">
    <div class="flex items-center justify-center mb-4 md:mb-6">
      <img
        src="../../../assets/images/nexcar-logo.svg"
        class="w-16 h-6 mr-1 md:w-32 md:h-10"
      >
      <p class="mr-1 text-lg font-medium sm:text-xl md:text-2xl lg:text-3xl">
        vs
      </p>
      <p class="text-lg font-medium sm:text-xl md:text-2xl lg:text-3xl">
        otras alternativas
      </p>
    </div>
    <p class="mb-5 text-base text-center text-gray-500 md:text-lg lg:text-2xl md:mb-6">
      Acá te explicamos por qué es más barato:
    </p>
    <div class="flex flex-col self-center px-5 py-3 -mx-6 bg-opacity-50 rounded-lg md:-mx-0 lg:max-w-7xl bg-nexcar-second-light-green lg:px-14 lg:py-7">
      <p class="mb-5 text-sm md:text-lg lg:text-xl">
        <span class="text-base font-semibold md:text-xl lg:text-2xl">Vehículo SUV automático</span> <br>
        Ejercicio de tener un auto por 3 años, andando 18.000 km anuales
      </p>
      <div class="grid grid-flow-col mb-6 text-xs lg:text-base custom-grid gap-y-4 xl:gap-x-4">
        <p class=" text-xxs lg:text-sm">
          <span class="text-nexcar-green">*</span>
          Cifras en miles de pesos
        </p>
        <span class="pr-2">Compra</span>
        <span class="pr-2">Impuesto y patente (x3)</span>
        <span class="pr-2">Mantenciones (x5)</span>
        <span class="pr-2">Seguros (x36 meses)</span>
        <div
          class="flex items-center pr-2"
          :class="{ 'cursor-pointer': this.$root.isMobile }"
          @click="showParagraphModal(soldAtThreeYears.content)"
        >
          <img
            src="../../../assets/images/icons/explanation-icon.svg"
            class="w-4 h-4 -ml-4 cursor-pointer md:-ml-5 md:w-5 md:h-5"
            v-tooltip.bottom="soldAtThreeYears"
          >
          <span>Venta a los 3 años</span>
        </div>
        <div
          class="flex items-center pr-2"
          :class="{ 'cursor-pointer': this.$root.isMobile }"
          @click="showParagraphModal(opportunityCost.content)"
        >
          <img
            src="../../../assets/images/icons/explanation-icon.svg"
            class="w-4 h-4 -ml-4 cursor-pointer md:w-5 md:h-5 md:-ml-5"
            v-tooltip.bottom="opportunityCost"
          >
          <span>Costo Oportunidad</span>
        </div>
        <span class="pr-2">Cuota final crédito</span>
        <div
          class="flex pr-2"
          :class="{ 'cursor-pointer': this.$root.isMobile }"
          @click="showParagraphModal(monthlyQuote.content)"
        >
          <img
            src="../../../assets/images/icons/explanation-icon.svg"
            class="w-4 h-4 -ml-4 cursor-pointer md:w-5 md:h-5 md:-ml-5"
            v-tooltip.bottom="monthlyQuote"
          >
          <span>Cuota Mensual</span>
        </div>
        <span class="pr-2 font-medium">Gasto Total</span>
        <div class="w-0.5 pb-4 border-r border-nexcar-green row-span-full mt-8" />
        <p class="text-xs font-medium text-center justify-self-center lg:text-lg">
          Compra al contado
        </p>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg">- $21.090</span>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg">- $1.613</span>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg">- $1.047</span>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg">- $1.815</span>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$ 13.023</span>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg">- $5.477</span>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pl-3 pr-4 font-medium text-right lg:pr-8 xl:pr-12 lg:text-lg">- $18.620</span>
        <p
          class="font-medium text-center justify-self-center lg:text-lg"
          v-if="!this.$root.isMedium"
        >
          Crédito automotriz
        </p>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $4.218
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.613
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.047
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.815
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green"
        >
          $ 13.023
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.095
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green"
        >
          $0
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $685
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 font-medium text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $22.026
        </span>
        <p
          class="text-xs font-medium text-center justify-self-center lg:text-lg"
          v-if="!this.$root.isMedium"
        >
          Compra inteligente
        </p>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $4.218
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.613
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.047
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.815
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 text-nexcar-green lg:text-lg"
        >
          $ 13.023
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $1.095
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          -$8.400
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $501
        </span>
        <span
          v-if="!this.$root.isMedium"
          class="pl-3 pr-4 font-medium text-right lg:pr-8 xl:pr-12 lg:text-lg"
        >
          - $23.082
        </span>
        <div class="w-0.5 pb-4 border-r border-nexcar-green row-span-full mt-8" />
        <img
          src="../../../assets/images/nexcar-logo.svg"
          class="w-16 h-5 justify-self-center lg:w-20 lg:h-6"
        >
        <span class="pr-1 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pr-1 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pr-1 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pr-1 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pr-1 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pr-1 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pr-1 text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">$0</span>
        <span class="pr-1 mb-8 text-right lg:pr-8 xl:pr-12 lg:text-lg">- $458</span>
        <span class="pb-4 pr-1 font-medium text-right lg:pr-8 xl:pr-12 lg:text-lg text-nexcar-green">- $16.488</span>
      </div>
      <p
        class="mb-8 text-base text-center lg:text-xl"
        v-if="this.$root.isMobile"
      >
        ¡El ahorro es incluso mayor
        <span class="font-semibold text-nexcar-green">versus crédito y compra inteligente!</span>
      </p>
    </div>
  </div>
</template>
<script>
import ParragraphModal from '../shared/parragraph-modal.vue';

export default {
  data() {
    return {
      tooltipClassesOption: ['bg-gray-700 text-white text-xs font-main p-2 rounded-md mt-1 w-48'],
    };
  },
  methods: {
    showParagraphModal(message) {
      if (!this.$root.isMobile) return;

      this.$modal.show(ParragraphModal, {
        message,
        messageClases: 'text-xs',
        modalClases: 'bg-nexcar-second-light-green bg-opacity-50',
      }, {
        width: '100%',
        maxWidth: this.$root.mdScreen,
        height: 'auto',
        adaptive: true,
        scrollable: true,
        name: 'paragraph-modal',
      });
    },
  },
  computed: {
    soldAtThreeYears() {
      return {
        // eslint-disable-next-line max-len
        content: 'Este valor incluye una comisión de venta equivalente al 5% del valor del auto en el año 3. Depreciaciones anuales de 18%, 10% y 10% para los años 1, 2 y 3 respectivamente.',
        classes: this.tooltipClassesOption,
      };
    },
    opportunityCost() {
      return {
        // eslint-disable-next-line max-len
        content: 'Costo por dejar de rentar o invertir el monto de compra. Calculado con un interés de UF+5% anual, rentabilidad asegurada por Nexcar al coinvertir con ellos.',
        classes: this.tooltipClassesOption,
      };
    },
    monthlyQuote() {
      return {
        content: 'Cobro mensual que multiplicado por los 36 meses te da el costo total del contrato.',
        classes: this.tooltipClassesOption,
      };
    },
  },
};
</script>
<style lang="scss">
.custom-grid {
  grid-template-columns: repeat(2, minmax(0, 1fr) min-content) minmax(0, 1fr);
  grid-template-rows: repeat(10, min-content);

  @media (min-width: 1024px) {
    grid-template-columns: minmax(0, 1fr) min-content repeat(3, minmax(0, 1fr)) min-content minmax(0, 1fr);
  }
}
.tooltip .tooltip-arrow {
  width: 0;
  height: 0;
  border-style: solid;
  position: absolute;
  margin: 5px;
  border-color: #374151;
  z-index: 1;
}

.tooltip[x-placement^="bottom"] .tooltip-arrow {
  border-width: 0 5px 5px;
  border-left-color: transparent !important;
  border-right-color: transparent !important;
  border-top-color: transparent !important;
  top: -5px;
  left: calc(50% - 5px);
  margin-top: 0;
  margin-bottom: 0;
}
</style>
