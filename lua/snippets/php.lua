local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("php", {

    -- Migration boilerplate
    s("mig", fmt([[
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{{
    public function up(): void
    {{
        Schema::create('{}', function (Blueprint $table) {{
            $table->id();
            {}
            $table->timestamps();
        }});
    }}

    public function down(): void
    {{
        Schema::dropIfExists('{}');
    }}
}};
]], { i(1, "table_name"), i(2, "// columns"), i(3, "table_name") })),

    -- Eloquent Model
    s("mod", fmt([[
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class {} extends Model
{{
    use HasFactory;

    protected $fillable = [
        {}
    ];
}}
]], { i(1, "ModelName"), i(2, "'field'") })),

    -- Resource Controller
    s("ctrl", fmt([[
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\{};
use Illuminate\Http\Request;

class {}Controller extends Controller
{{
    public function index() {{ {} }}

    public function create() {{ {} }}

    public function store(Request $request) {{ {} }}

    public function show({} ${}) {{ {} }}

    public function edit({} ${}) {{ {} }}

    public function update(Request $request, {} ${}) {{ {} }}

    public function destroy({} ${}) {{ {} }}
}}
]], {
        i(1, "Model"), i(2, "Model"),
        i(3), i(4), i(5),
        i(6, "Model"), i(7, "model"), i(8),
        i(9, "Model"), i(10, "model"), i(11),
        i(12, "Model"), i(13, "model"), i(14),
        i(15, "Model"), i(16, "model"), i(17),
    })),

    -- Form Request
    s("req", fmt([[
namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class {} extends FormRequest
{{
    public function authorize(): bool
    {{
        return {};
    }}

    public function rules(): array
    {{
        return [
            {}
        ];
    }}
}}
]], { i(1, "StoreModelRequest"), i(2, "true"), i(3, "'field' => 'required'") })),

    -- Job class
    s("job", fmt([[
namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class {} implements ShouldQueue
{{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function __construct(
        {}
    ) {{}}

    public function handle(): void
    {{
        {}
    }}
}}
]], { i(1, "ProcessJob"), i(2), i(3) })),

    -- Event class
    s("evt", fmt([[
namespace App\Events;

use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class {}
{{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public function __construct(
        {}
    ) {{}}
}}
]], { i(1, "UserRegistered"), i(2) })),

    -- API Resource
    s("api", fmt([[
namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class {} extends JsonResource
{{
    public function toArray(Request $request): array
    {{
        return [
            'id' => $this->id,
            {}
        ];
    }}
}}
]], { i(1, "ModelResource"), i(2) })),

    -- PHPUnit/Pest Test
    s("test", fmt([[
namespace Tests\{};

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class {} extends TestCase
{{
    use RefreshDatabase;

    public function test_{}(): void
    {{
        {}
    }}
}}
]], { i(1, "Feature"), i(2, "ExampleTest"), i(3, "example_behavior"), i(4) })),

    -- Factory
    s("fact", fmt([[
namespace Database\Factories;

use App\Models\{};
use Illuminate\Database\Eloquent\Factories\Factory;

class {}Factory extends Factory
{{
    public function definition(): array
    {{
        return [
            {}
        ];
    }}
}}
]], { i(1, "Model"), i(2, "Model"), i(3) })),

    -- Seeder
    s("seed", fmt([[
namespace Database\Seeders;

use Illuminate\Database\Seeder;

class {} extends Seeder
{{
    public function run(): void
    {{
        {}
    }}
}}
]], { i(1, "ModelSeeder"), i(2) })),

})
