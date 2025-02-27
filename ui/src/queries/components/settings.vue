<template>
  <div class="bg-white">
    <Tabs
      v-if="preferences.variables.length"
      v-model="selectedTab"
      :position="'center'"
      :tabs="[
        { label: 'Visualization', value: 'visualization' },
        { label: 'Variables', value: 'variables' },
      ]"
    />
    <div
      :style="{
        height: `calc(var(--vh, 100vh) - ${preferences.variables.length ? '224px' : '185px' })`,
        overflowY: 'scroll'
      }"
      class="p-2"
    >
      <template v-if="selectedTab === 'variables'">
        <Card
          v-for="variable in preferences.variables"
          :key="variable.name"
          class="my-2"
        >
          <div class="fw-bold mb-3">
            {{ variable.display_name }}
          </div>
          <VariableSettings :variable="variable" />
        </Card>
      </template>
      <template v-else>
        <p class="fs-4 fw-bold my-1">
          Display as
        </p>
        <RadioGroup
          v-model="preferences.visualization"
          class="d-flex flex-column"
        >
          <Radio
            v-for="option in visualizationOptions"
            :key="option.value"
            :label="option.value"
            border
            size="large"
            class="my-1 me-0"
            @update:modelValue="maybeSetLabelFormat"
          >
            {{ option.label }}
          </Radio>
        </RadioGroup>
        <template v-if="['bar_chart', 'row_chart', 'line_chart', 'funnel'].includes(preferences.visualization)">
          <Checkbox
            v-model="preferences.visualization_options.chart_values_axis"
            class="d-block"
          >
            Values axis
          </Checkbox>
          <Checkbox
            v-if="['bar_chart', 'row_chart'].includes(preferences.visualization)"
            v-model="preferences.visualization_options.chart_stacked"
            class="d-block"
          >
            Stacked bars
          </Checkbox>
        </template>
        <template v-if="!['table', 'markdown', 'value'].includes(preferences.visualization)">
          <p class="fs-4 fw-bold my-1">
            Format
          </p>
          <RadioGroup
            v-model="preferences.visualization_options.label_format"
            class="d-flex flex-column"
            @update:modelValue="maybeSetCurrency"
          >
            <Radio
              v-for="option in formatOptions"
              :key="option.value"
              :label="option.value"
              border
              size="large"
              class="my-1 me-0"
            >
              {{ option.label }}
            </Radio>
          </RadioGroup>
        </template>
        <template v-if="!['table', 'markdown'].includes(preferences.visualization) && preferences.visualization_options.label_format === 'currency'">
          <p class="fs-4 fw-bold my-1">
            Currency
          </p>
          <CurrencySelect
            v-model="preferences.visualization_options.label_format_options.currency"
          />
        </template>
      </template>
    </div>
    <div class="footer p-2">
      <VButton
        long
        type="default"
        @click="$emit('close')"
      >
        OK
      </VButton>
    </div>
  </div>
</template>

<script>
import CurrencySelect from 'utils/components/currency_select'
import Tabs from 'utils/components/tabs'
import VariableSettings from '../components/variable_settings'

export default {
  name: 'QuerySettings',
  components: {
    CurrencySelect,
    Tabs,
    VariableSettings
  },
  props: {
    preferences: {
      type: Object,
      required: true
    },
    columns: {
      type: Array,
      required: false,
      default: () => []
    }
  },
  emits: ['close'],
  data () {
    return {
      selectedTab: 'visualization'
    }
  },
  computed: {
    visualizationOptions () {
      return [
        { label: 'Table', value: 'table' },
        { label: 'Value', value: 'value' },
        { label: 'Markdown', value: 'markdown' },
        { label: 'Line chart', value: 'line_chart' },
        { label: 'Bar chart', value: 'bar_chart' },
        { label: 'Row chart', value: 'row_chart' },
        { label: 'Pie chart', value: 'pie_chart' },
        { label: 'Funnel', value: 'funnel' }
      ]
    },
    formatOptions () {
      return [
        { label: 'Decimal', value: 'decimal' },
        { label: 'Percent', value: 'percent' },
        { label: 'Currency', value: 'currency' }
      ]
    }
  },
  methods: {
    maybeSetLabelFormat (value) {
      if (!['table', 'markdown'].includes(value)) {
        this.preferences.visualization_options.label_format ||= 'decimal'
        this.preferences.visualization_options.label_format_options ||= {}
      }
    },
    maybeSetCurrency (value) {
      if (value === 'currency') {
        this.preferences.visualization_options.label_format_options ||= {}
        this.preferences.visualization_options.label_format_options.currency ||= 'USD'
      }
    }
  }
}
</script>

<style lang="scss" scoped>
:deep(.ivu-tabs-bar) {
  margin-bottom: 0px
}

.footer {
  width: 100%;
  position: sticky;
  bottom: 0;
  left: 0;
  border-top: 1px solid #e8e8e8;
  padding-top: 8px;
  text-align: right;
  background: #fff;
}
</style>
