<template>
  <div
    class="grid grid-cols-1 col-span-2 px-10 py-4 rounded-lg shadow bg-nexcar-light-green md:grid-cols-2 md:col-span-3 gap-x-9 gap-y-2 md:gap-y-7 bg-opacity-20"
    v-if="!requestConfirmed"
  >
    <div
      class="flex col-span-1 text-gray-600 cursor-pointer md:col-span-2"
      @click="$emit('change-request-car-model')"
    >
      <img
        src="../../../assets/images/back-icon.svg"
        class="mr-4"
      >
      Volver
    </div>
    <div class="col-span-1 md:col-span-2">
      <p class="mb-2 text-xl font-medium text-gray-600">
        ¿No encuentras tu auto favorito?
      </p>
      <p class="mb-2 text-sm text-nexcar-green">
        Rellena el siguiente formulario y ¡solicítalo!
      </p>
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        Nombre
      </p>
      <field-missing v-if="!firstName && fillMessageAllow" />
      <input
        class="w-full p-2 mb-2 border rounded-md focus:outline-none"
        type="text"
        v-model="firstName"
      >
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        Apellido
      </p>
      <field-missing v-if="!lastName && fillMessageAllow" />
      <input
        class="w-full p-2 mb-2 border rounded-md focus:outline-none"
        type="text"
        v-model="lastName"
      >
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        Marca
      </p>
      <field-missing v-if="!brand && fillMessageAllow" />
      <input
        class="w-full p-2 mb-2 border rounded-md focus:outline-none"
        type="text"
        v-model="brand"
      >
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        Modelo
      </p>
      <field-missing v-if="!model && fillMessageAllow" />
      <input
        class="w-full p-2 mb-2 border rounded-md focus:outline-none"
        type="text"
        v-model="model"
      >
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        Distancia Anual (Km)
      </p>
      <field-missing v-if="!annualDistance && fillMessageAllow" />
      <multiselect
        class="w-full rounded-md"
        v-model="annualDistance"
        :options="annualDistanceOptions"
        :multiple="false"
        :close-on-select="false"
        :clear-on-select="false"
        :preserve-search="true"
        :searchable="true"
        placeholder=""
      />
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        Tiempo de Contrato (meses)
      </p>
      <field-missing v-if="!contractTime && fillMessageAllow" />
      <multiselect
        class="w-full rounded-md"
        v-model="contractTime"
        :options="contractTimeOptions"
        :multiple="false"
        :close-on-select="false"
        :clear-on-select="false"
        :preserve-search="true"
        :searchable="true"
        placeholder=""
      />
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        ¡Dejanos tu correo para contactarte!
      </p>
      <field-missing
        :fill-message="email ? emailValidationMessage : fillMessage"
        v-if="!validEmail && fillMessageAllow"
      />
      <input
        class="w-full p-2 mb-2 border rounded-md focus:outline-none"
        type="text"
        v-model="email"
      >
    </div>
    <div class="col-span-1">
      <p class="text-gray-600">
        Número de teléfono
      </p>
      <field-missing
        :fill-message="phoneNumber ? phoneNumberValidationMessage : fillMessage"
        v-if="!validPhoneNumber && fillMessageAllow"
      />
      <div class="flex w-full">
        <input
          class="w-12 p-2 mb-2 border border-r-0 rounded-md rounded-r-none focus:outline-none"
          readonly
          placeholder="+56 "
          type="text"
        >
        <input
          class="w-full p-2 mb-2 border border-l-0 rounded-md rounded-l-none focus:outline-none"
          type="text"
          v-model="phoneNumber"
        >
      </div>
    </div>
    <div class="col-span-1 md:col-span-2">
      <p class="text-gray-600">
        Comentanos cualquier otra consideración que quieras
      </p>
      <textarea
        class="w-full p-2 mb-2 border rounded-md focus:outline-none"
        type="text"
        v-model="comment"
      />
    </div>
    <button
      class="w-1/2 p-2 mb-4 border rounded-md bg-nexcar-green md:col-span-2 focus:outline-none hover:bg-nexcar-dark-green justify-self-center"
      @click="confirm"
    >
      Enviar
    </button>
  </div>
  <div
    v-else
    class="flex flex-col justify-center p-4"
  >
    <p class="mb-4 text-3xl">
      ¡Tu solicitud ha sido enviada correctamente!
    </p>
  </div>
</template>
<script>
import carModelRequestApi from '../../api/car_model_request';
import fieldMissing from '../shared/field-missing.vue';
import formattedEmail from '../mixins/formattedEmail';

export default {
  mixins: [formattedEmail],
  components: { fieldMissing },
  data() {
    return {
      email: '',
      firstName: '',
      lastName: '',
      brand: '',
      model: '',
      annualDistance: '',
      contractTime: '',
      comment: '',
      phoneNumber: '',
      requestConfirmed: false,
      errorMessage: '',
      errorFound: false,
      fillMessageAllow: false,
      fillMessage: 'Falta completar este campo',
      emailValidationMessage: 'El formato es incorrecto',
      phoneNumberValidationMessage: 'El número de teléfono debe contener 9 dígitos exclusivamente',
    };
  },
  props: {
    annualDistanceOptions: { type: Array, require: true, default() { return []; } },
    contractTimeOptions: { type: Array, require: true, default() { return []; } },
  },
  computed: {
    completeAttributes() {
      return this.completeName && this.brand && this.model && this.annualDistance &&
        this.contractTime && this.validContactInformation;
    },
    validContactInformation() {
      return this.validEmail && this.validPhoneNumber;
    },
    completeName() {
      return this.firstName && this.lastName;
    },
    validPhoneNumber() {
      return (/^[0-9]{9}$/i).test(this.phoneNumber);
    },
  },
  methods: {
    confirm() {
      if (this.completeAttributes) {
        this.sendRequest();
      } else {
        this.fillMessageAllow = true;
      }
    },
    async sendRequest() {
      const body = { email: this.email, brand: this.brand, model: this.model,
        annualDistance: this.annualDistance, contractTime: this.contractTime,
        firstName: this.firstName, lastName: this.lastName, comment: this.comment,
        phoneNumber: this.phoneNumber };
      try {
        await carModelRequestApi.create(body);
        this.requestConfirmed = true;
        this.$emit('change-request-car-model');
      } catch (error) {
        this.errorMessage = error;
        this.errorFound = true;
      }
    },
  },
};
</script>
