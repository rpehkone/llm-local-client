const fragmentShaderHeader =
`#version 300 es
precision mediump float;
uniform vec2 iResolution;
uniform vec4 iMouse;
uniform float iTime;
out vec4 fragColor;
`;

var program;

const canvas = document.getElementById('canvas');
const gl = canvas.getContext('webgl2')

var iMouse = [0, 0]
canvas.addEventListener('mousemove', function (event) {
    const rect = canvas.getBoundingClientRect();
    const scaleX = canvas.width / rect.width;
    const scaleY = canvas.height / rect.height;

    iMouse[0] = (event.clientX - rect.left) * scaleX;
    iMouse[1] = (canvas.height - (event.clientY - rect.top) * scaleY);
});

function render(time) {

    gl.viewport(0, 0, canvas.width, canvas.height);

    gl.clear(gl.COLOR_BUFFER_BIT);

	const rect = canvas.getBoundingClientRect();
    gl.uniform2f(gl.getUniformLocation(program, "iResolution"), rect.width, rect.height);

    gl.uniform4f(gl.getUniformLocation(program, "iMouse"), iMouse[0], iMouse[1], 0, 0);

    const iTime = time * 0.001; // Convert to seconds
    gl.uniform1f(gl.getUniformLocation(program, "iTime"), iTime);

    gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);

    requestAnimationFrame(render);
}


////////////////// init
////////////////// init
////////////////// init
////////////////// init
////////////////// init

function createShader(gl, type, source) {
	const shader = gl.createShader(type);
	gl.shaderSource(shader, source);
	gl.compileShader(shader);

	if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
		throw new Error(gl.getShaderInfoLog(shader));
		return null;
	}

	return shader;
}

function createProgram(gl, getvertexShader, getfragmentShader) {
	const program = gl.createProgram();
	gl.attachShader(program, getvertexShader);
	gl.attachShader(program, getfragmentShader);
	gl.linkProgram(program);

	if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
		console.error(gl.getProgramInfoLog(program));
		gl.deleteProgram(program);
		return null;
	}

	return program;
}

const vertexShaderSource = `#version 300 es
in vec2 a_position;
void main() {
	gl_Position = vec4(a_position, 0.0, 1.0);
}
`;

const vertexShader = createShader(gl, gl.VERTEX_SHADER, vertexShaderSource);
var fragmentShader;

function toy_to_glsl(user_shader) {
	user_shader = user_shader.replace(/mainImage\(.*\)/, "main()");
	user_shader = user_shader.replace(/fragCoord/g, "gl_FragCoord.xy");
    return user_shader;
}

function init_render(user_shader) {
    user_shader = toy_to_glsl(user_shader);

	let frag = fragmentShaderHeader + user_shader;
    // console.log(frag)

	fragmentShader = createShader(gl, gl.FRAGMENT_SHADER, frag);
	program = createProgram(gl, vertexShader, fragmentShader);

	const positionAttributeLocation = gl.getAttribLocation(program, "a_position");
	const positionBuffer = gl.createBuffer();
	gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 1, -1, -1, 1, 1, 1]), gl.STATIC_DRAW);

	gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);
	gl.clearColor(0, 0, 0, 0);
	gl.clear(gl.COLOR_BUFFER_BIT);

	gl.useProgram(program);
	gl.enableVertexAttribArray(positionAttributeLocation);
	gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
	gl.vertexAttribPointer(positionAttributeLocation, 2, gl.FLOAT, false, 0, 0);
}
