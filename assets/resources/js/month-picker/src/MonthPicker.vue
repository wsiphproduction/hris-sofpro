<template>
  <div
    class="month-picker-container"
    :class="`month-picker--${variant}`"
  >
    <div
      v-if="showYear"
      class="month-picker-year"
    >
      <button type="button" @click="changeYear(-1)">
        &lsaquo;
      </button>
      <p v-if="!editableYear">
        {{ year }}
      </p>
      <input
        v-else
        type="text"
        v-model.number="year"
        @change="onChange()"
      >
      <button type="button" @click="changeYear(+1)">
        &rsaquo;
      </button>
    </div>
    <div class="month-picker">
      <div
        v-for="(month, i) in monthsByLang"
        :key="month" 
        :class="currentMonth === month ? 'selected' : ''"
        class="month-picker-month"
        @click="selectMonth(i, true)"
      >
        {{ month }}
      </div>
    </div>
  </div>
</template>

<script>
import languages from './languages'
import monthPicker from './month-picker'

export default {
  name: 'en',
  mixins: [monthPicker],
  data() {
    return {
      currentMonthIndex: null,
      year: new Date().getFullYear()
    }
  },
  computed: {
    monthsByLang: function() {
      if (this.months !== null && 
          this.months.length === 12) {
        return this.months
      }
      return languages[this.lang]
    },
    currentMonth: function() {
      if (this.currentMonthIndex !== null) {
        return this.monthsByLang[this.currentMonthIndex]
      }
    },
    date: function() {
      const month = this.monthsByLang.indexOf(this.currentMonth) + 1
      const date = new Date(`${this.year}/${month}/01`)
      const year = date.getFullYear()

      return {
        from: date,
        to: new Date(year, month, 1),
        month: this.monthsByLang[month - 1],
        monthIndex: month,
        year: year
      }
    }
  },
  mounted() {
    if (this.defaultMonth) {
      this.selectMonth(this.defaultMonth - 1)
    } else if (!this.noDefault) {
      this.selectMonth(0)
    }

    if (this.defaultYear) {
      this.year = this.defaultYear
    }
  },
  methods: {
    onChange() {
      this.$emit('change', this.date)
    },
    selectMonth(index, input = false) {
      const isAlreadySelected = this.currentMonthIndex === index
      if (this.clearable && isAlreadySelected) {
        this.currentMonthIndex = null
        this.$emit('clear')
        return
      }

      if (this.isAlreadySelected) {
        return
      }

      this.currentMonthIndex = index
      this.onChange()
      if (input) {
        this.$emit('input', this.date)
      }
    },
    changeYear(value) {
      this.year += value
      this.onChange()
      this.$emit('change-year', this.year)
    }
  }
}
</script>

<style>
.month-picker-container {
  width: 300px;
  position: relative;
  border: 1px solid #DDDDDD;
  border-radius: 3px;
  background: #FFFFFF;
}

.month-picker {
  box-sizing: border-box;
  flex: 1;
  width: auto;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  box-shadow: 1px 2px 5px rgba(0, 0, 0, 0.1);
  font-family: sans-serif;
  border-radius: 5px;
  overflow: hidden;
}
.month-picker-year{
  height: 50px;
}
.month-picker-year p {
  width: 100%;
  font-weight: 600;
  letter-spacing: 1px;
  font-size: 1.2em;
  line-height: 50px;
}

.month-picker-year input {
  padding: 0;
  font-weight: 600;
  border-radius: 5px 5px 0 0;
  outline: none;
  border: none;
  font-size: 1.2em;
  width: auto;
  text-align: center;
  box-sizing: border-box;
  width: 100%;
  height: 3em;
  position: relative;
  z-index: 1;
}

.month-picker-year input:focus {
  border: 1px solid #55B0F2;
}

.month-picker-year div,
.month-picker-year button,
.month-picker-year p {
  text-align: center;
  flex: 1;
}

.month-picker-year button {
  background-color: #FFFFFF;
  position: absolute;
  width: 2em;
  font-size: 2em;
  border-radius: 5px;
  outline: none;
  border: 0;
  top: 1px;
  z-index: 2;
  line-height: 45px;
}

.month-picker-year button:hover {
  background-color: rgba(0, 0, 0, 0);
}

.month-picker-year button:active {
  background-color: rgba(0, 0, 0, 0);
}

.month-picker-year button:first-child {
  left: 1px;
}

.month-picker-year button:last-child {
  right: 1px;
}

.month-picker-month {
  flex-basis: calc(33.333%);
  padding: 0.75em 0.25em;
  cursor: pointer;
  text-align: center;
  border: 1px solid #f5f5f5;
  background-color: #FFF;
}

.month-picker-month.selected,
.month-picker-month:hover {
  background-color: #007bff;
  color: #FFFFFF;
}

.month-picker--dark {
  background-color: #5F5F5F;
}

.month-picker--dark .month-picker-year p,
.month-picker--dark .month-picker-year input {
  color: #EBEBEB;
}

.month-picker--dark .month-picker-year button {
  background-color: #505050;
  color: #C9C9C9;
  border-color: #1E1E1E;
}

.month-picker--dark .month-picker-month {
  background-color: #2F2F30;
  border-color: rgba(245, 245, 245, .15);
  color: #C9C9C9;
}

.month-picker--dark .month-picker-month.selected {
  background-color: #505050;
  box-shadow: inset 0 0 3px #505050, 0px 2px 5px #505050;
  color: #FFFFFF;
  border-color: #1E1E1E;
}
</style>
