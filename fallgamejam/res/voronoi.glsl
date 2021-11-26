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

vec4 effect(vec4 color, Image texture, vec2 tc, vec2 pixel_coord) {
        float min_dist_sq = distance_squared(pixel_coord, vertex_positions[0]);
        vec4 nearest_color = colors[0];

        for (int i = 1; i < num_vertex_positions; i++) {
                float dist_sq = distance_squared(pixel_coord, vertex_positions[i]);
                if (dist_sq < min_dist_sq) {
                        min_dist_sq = dist_sq;
                        nearest_color = colors[vertex_colors[i]];
                }
        }

        return nearest_color;
}
