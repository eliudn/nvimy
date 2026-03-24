local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("blade", {

    -- Layout base
    s("layout", fmt([[
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', '{}')</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body>
    {}
    @yield('content')
</body>
</html>
]], { i(1, "App"), i(2) })),

    -- Component
    s("comp", fmt([[
@props([
    '{}' => {},
])

<div {}>{}</div>
]], { i(1, "prop"), i(2, "null"), i(3), i(4) })),

    -- Forelse loop
    s("fore", fmt([[
@forelse ({} as ${})
    {}
@empty
    <p>{}</p>
@endforelse
]], { i(1, "$items"), i(2, "item"), i(3), i(4, "No items found") })),

    -- Conditional section
    s("ifsec", fmt([[
@if ({})
    {}
@else
    {}
@endif
]], { i(1, "condition"), i(2), i(3) })),

    -- Form con CSRF
    s("form", fmt([[
<form action="{{ route('{}') }}" method="POST">
    @csrf
    {}
    <button type="submit">{}</button>
</form>
]], { i(1, "route.name"), i(2), i(3, "Submit") })),

    -- Auth check
    s("auth", fmt([[
@auth
    {}
@endauth
@guest
    {}
@endguest
]], { i(1), i(2) })),

    -- Include with data
    s("inc", fmt([[
@include('{}', ['{}' => ${}])
]], { i(1, "partials.component"), i(2, "variable"), i(3, "value") })),

    -- Section con yield
    s("sec", fmt([[
@section('{}')
    {}
@endsection
]], { i(1, "content"), i(2) })),

    -- Livewire component
    s("live", fmt([[
@livewire('{}'{})
]], { i(1, "component-name"), i(2) })),

})
