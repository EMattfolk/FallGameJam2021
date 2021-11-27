extern vec2 vertex_positions[20];
extern int vertex_colors[20];
extern int num_vertex_positions;

vec4 colors[4] = vec4[](
        vec4(1., 0., 0., 1.),
        vec4(0., 1., 0., 1.),
        vec4(0., 0., 1., 1.),
        vec4(1., 1., 0., 1.)
);

float distance_squared(vec2 p1, vec2 p2) {
        vec2 diff = p2 - p1;
        return dot(diff, diff);
}

float get_border(vec2 pixel_coord, ivec2 nearest_vertices) {
        vec2 a = vertex_positions[nearest_vertices.x];
        vec2 b = vertex_positions[nearest_vertices.y];

        vec2 midpoint = (a + b) * 0.5;
        vec2 direction = normalize(b - a);

        float d = -dot(pixel_coord - midpoint, direction);

        if (d < 5.0) return 1.0;
        return 0.0;
}

vec4 effect(vec4 color, Image texture, vec2 tc, vec2 pixel_coord) {
        vec2 min_dist_sq = vec2(999999.0);
        ivec2 nearest_vertices = ivec2(0);

        for (int i = 0; i < num_vertex_positions; i++) {
                float dist_sq = distance_squared(pixel_coord, vertex_positions[i]);

                if (dist_sq < min_dist_sq.x) {
                        min_dist_sq.y = min_dist_sq.x;
                        min_dist_sq.x = dist_sq;
                        nearest_vertices.y = nearest_vertices.x;
                        nearest_vertices.x = i;
                } else if (dist_sq < min_dist_sq.y) {
                        min_dist_sq.y = dist_sq;
                        nearest_vertices.y = i;
                }
        }

        vec4 nearest_color = colors[vertex_colors[nearest_vertices.x]];
        vec2 dist = sqrt(min_dist_sq);
        vec4 cell_color = mix(vec4(1), nearest_color, 100.0 / dist.x);

        float border = get_border(pixel_coord, nearest_vertices);
        vec4 border_color = vec4(0, 0, 0, 1);

        vec4 fragment_color = mix(cell_color, border_color, border);

        return fragment_color;
}
