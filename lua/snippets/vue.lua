local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("vue", {

    -- Vue SFC completo con script setup
    s("sfc", fmt([[
<script setup lang="ts">
{}
</script>

<template>
    <div>
        {}
    </div>
</template>

<style scoped>
{}
</style>
]], { i(1), i(2), i(3) })),

    -- defineProps con tipado TS
    s("prop", fmt([[
const props = defineProps<{{
    {}: {}
}}>()
]], { i(1, "propName"), i(2, "string") })),

    -- defineEmits con tipado TS
    s("emit", fmt([[
const emit = defineEmits<{{
    (e: '{}', value: {}): void
}}>()
]], { i(1, "update:modelValue"), i(2, "string") })),

    -- Composable useX
    s("comp", fmt([[
import {{ ref, computed }} from 'vue'

export function use{}() {{
    const {} = ref<{}>({})

    {}

    return {{
        {},
    }}
}}
]], { i(1, "Feature"), i(2, "state"), i(3, "string"), i(4, "''"), i(5), i(6, "state") })),

    -- Pinia store
    s("pinia", fmt([[
import {{ defineStore }} from 'pinia'
import {{ ref, computed }} from 'vue'

export const use{}Store = defineStore('{}', () => {{
    const {} = ref<{}>({})

    {}

    return {{
        {},
    }}
}})
]], { i(1, "Feature"), i(2, "feature"), i(3, "state"), i(4, "string"), i(5, "''"), i(6), i(7, "state") })),

    -- Composable API fetch
    s("fetch", fmt([[
import {{ ref }} from 'vue'

export function use{}Api() {{
    const data = ref<{} | null>(null)
    const loading = ref(false)
    const error = ref<string | null>(null)

    async function fetch{}() {{
        loading.value = true
        error.value = null
        try {{
            const response = await $fetch<{}>('{}')
            data.value = response
        }} catch (err) {{
            error.value = 'Error al cargar datos'
        }} finally {{
            loading.value = false
        }}
    }}

    return {{ data, loading, error, fetch{} }}
}}
]], { i(1, "Model"), i(2, "Model"), i(3, "Model"), i(4, "Model"), i(5, "/api/endpoint"), i(6, "Model") })),

    -- ref tipado
    s("ref", fmt([[
const {} = ref<{}>({})
]], { i(1, "variable"), i(2, "string"), i(3, "''") })),

    -- computed tipado
    s("comp2", fmt([[
const {} = computed<{}>(() => {{
    return {}
}})
]], { i(1, "derived"), i(2, "string"), i(3) })),

    -- watch
    s("watch", fmt([[
watch({}, (newValue, oldValue) => {{
    {}
}})
]], { i(1, "source"), i(2) })),

    -- onMounted
    s("onm", fmt([[
onMounted(() => {{
    {}
}})
]], { i(1) })),

})

-- TypeScript snippets (reutilizables en .ts)
ls.add_snippets("typescript", {

    -- Interface TS
    s("iface", fmt([[
interface {} {{
    {}: {}
}}
]], { i(1, "Model"), i(2, "id"), i(3, "number") })),

    -- Type alias
    s("type", fmt([[
type {} = {{
    {}: {}
}}
]], { i(1, "Model"), i(2, "id"), i(3, "number") })),

    -- Async function
    s("afn", fmt([[
async function {}({}): Promise<{}> {{
    {}
}}
]], { i(1, "fetchData"), i(2), i(3, "void"), i(4) })),

})
