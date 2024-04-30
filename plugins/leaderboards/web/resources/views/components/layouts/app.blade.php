<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}"
    class="bg-slate-800 font-sans h-full">

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>@isset($title){{ $title }}&nbsp;&bull;&nbsp;@endif{{ config('app.name') }}</title>

    @vite('resources/css/app.css')
</head>

<body class="flex flex-col h-full text-white">
    <header class="bg-slate-900">
        <div class="container mx-auto p-6 px-8">
            <div class="flex justify-between items-center">
                <a href="{{ route('leaderboards.index') }}">
                    <img src="/images/logo.png" alt="Logo" class="h-24 w-auto">
                </a>
                <div class="flex flex-col gap-2 text-right">
                    @isset($title)
                        <h2 class="text-2xl font-bold">
                            {{ $title }}
                        </h2>
                    @endif
                    @isset($subtitle)
                        <p>
                            {{ $subtitle }}
                        </p>
                    @endif
                </div>
            </div>
        </div>
    </header>

    <main class="container mx-auto p-6 px-8 flex-1">
        {{ $slot }}
    </main>

    <footer class="bg-slate-900 text-center">
        <div class="container mx-auto p-6 px-8 text-xs">
            &copy; {{ date('Y') }} Experiment Redux
        </div>
    </footer>
</body>

</html>
