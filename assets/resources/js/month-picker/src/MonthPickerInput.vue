<template>
  <div
    class="month-picker-input-container"
    v-click-outside="hide"
  >
    <input
      class="form-control"
      type="text"
      v-model="selectedDate"
      @click="showMonthPicker()"
    >
    <month-picker
      v-show="monthPickerVisible"
      @input="populateInput"
      :default-year="defaultYear"
      :default-month="defaultMonth"
      :lang="lang"
      :months="months"
      :no-default="noDefault"
      :show-year="showYear"
      :clearable="clearable"
      :variant="variant"
      :editable-year="editableYear"
    >
    </month-picker>
  </div>
</template>

<script>
import Vue from 'vue'
import MonthPicker from './MonthPicker.vue'
import monthPicker from './month-picker'

export default {
  name: 'en',
  mixins: [monthPicker],
  directives: {
    clickOutside: {
      bind: function (el, binding, vnode) {
        el.event = function (event) {
          if (!(el === event.target || el.contains(event.target))) {
            vnode.context[binding.expression](event)
          }
        }
        document.body.addEventListener('click', el.event)
      },
      unbind: function (el) {
        document.body.removeEventListener('click', el.event)
      }
    }
  },
  data() {
    return {
      monthPickerVisible: false,
			selectedDate: null
    }
  },
  components: {
		MonthPicker
	},
  methods: {
    populateInput (date) {
			this.selectedDate = `${date.month}, ${date.year}`
			this.monthPickerVisible = false
      this.$emit("input", date)
		},
		showMonthPicker () {
			this.monthPickerVisible = !this.monthPickerVisible
    },
    hide () {
      this.monthPickerVisible = false
    }
  }
}
</script>
<style scoped>
  .month-picker-input-container {
    position: relative;
    width: 100%;
  }

  .month-picker-input {
    display: block;
    width: 100%;
    height: calc(1.5em + .75rem + 2px);
    padding: .375rem .75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: .25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
  }

  .month-picker-input:focus {
    color: #495057;
    background-color: #fff;
    border-color: #80bdff;
    outline: 0;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
  }

  .month-picker-container {
    position: absolute;
    top: 3em;
    z-index: 99;
  }
</style>
