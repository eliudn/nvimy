return {
    {

        "milanglacier/minuet-ai.nvim",

        event = "InsertEnter",
        opts = {
            provider         = "gemini",

            -- Usar Claude via API compatible
            provider_options = {
                gemini = {
                    -- model    = "gemma-4-31b-it",
                    -- api_key  = "GEMINI_API_KEY2",
                    model    = "gemma-4-31b-it",
                    api_key  = "MISTRAL_API_KEY",
                    stream   = true,
                    optional = {
                        generationConfig = {
                            maxOutputTokens = 128,
                        },
                    },
                },
            },
            virtualtext = {
                auto_trigger_ft = {},

            },

            -- Throttle para no disparar en cada keystroke
            throttle         = 3000, -- ms entre requests
            debounce         = 800,
            request_timeout  = 3,

            -- Cuántas sugerencias mostrar
            n_completions    = 2,
        },
    },
    { 'nvim-lua/plenary.nvim' },
    -- optional, if you are using virtual-text frontend, nvim-cmp is not
    -- required.
    { 'hrsh7th/nvim-cmp' },
}
