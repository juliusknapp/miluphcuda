# miluphcuda

Miluphcuda is a smoothed particle hydrodynamics code


## Related pages

* [Extra Markdown file](ExtraMarkdown.md)
* [Miluphcuda documentation (as md link)](miluphcuda_documentation.pdf)
* <a href="miluphcuda_documentation.pdf" target="_blank"><b>Miluphcuda documentation (as html link)</b></a>

## Project structure

* **docs** 
* **material_data**
* **test_cases**: test cases for miluphcuda
* ...

## About

miluphcuda is the cuda port of the original miluph code.
miluphcuda can be used to model fluids and solids. 
miluphcuda runs on single Nvidia GPUs with compute capability 5.0 and higher.


Main features are

* SPH hydro and solid
* self-gravity (via Barnes-Hut tree)
* porosity models (P-alpha, epsilon-alpha, Sirono)



## Developers

Christoph M. Schaefer,
Sven Riecker,
Oliver Wandel,
Thomas I. Maindl,
Samuel Scherrer,
Janka Werner,
Christoph Burger,
Marius Morlock,
Evita Vavilina,
Michael Staneker,
Maximilian Rutz.
