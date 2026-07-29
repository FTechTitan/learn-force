begin;

update public.course_modules as module
set theory = source.theory
from (
  values
    (
      'pmp-introduccion-sesiones',
      $html$
<h3>Resumen practico</h3>
<p>Inicio del programa: orientacion, enfoque comercial y primeras sesiones para activar la maquina de pacientes. El objetivo es entender el embudo, ordenar las publicaciones y convertir conversaciones en oportunidades reales.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/1bYKL0vTtbzN-TMtaXr2JRWTgAHLJrgLC/view" target="_blank" rel="noopener">Bienvenida</a></li>
  <li><a href="https://drive.google.com/file/d/1_mPi820pxk3fbhr4AjOUxCK5lk3ShkEW/view" target="_blank" rel="noopener">Sesion 1 - Entrenamiento inicial</a></li>
  <li><a href="https://drive.google.com/file/d/1tSJOviiz6UiCZZUczLt7XfblZw_TYOHC/view" target="_blank" rel="noopener">Sesion 2 - Palabras poderosas</a></li>
  <li><a href="https://drive.google.com/file/d/1rcAa05EP_Aig0qdMIadT3aIpnW5JFsOc/view" target="_blank" rel="noopener">Sesion 3 - Embudo de la maquina de pacientes</a></li>
  <li><a href="https://drive.google.com/file/d/1Nhgf0e3XUYzVu_q__xD_js0AD3Iema42/view" target="_blank" rel="noopener">Sesion 4 - Activa codigos en el cerebro de tu paciente</a></li>
  <li><a href="https://drive.google.com/file/d/16gquCFTRgLZ5rXv3BYkJYSL8RMvWxgsW/view" target="_blank" rel="noopener">Sesion 5 - Disena publicaciones para atraer clientes</a></li>
  <li><a href="https://drive.google.com/file/d/1OLT117Opc6UYCQIS_w-6VCTv7_BRJBXj/view" target="_blank" rel="noopener">Sesion 6 - La lluvia de posibles pacientes</a></li>
</ul>
$html$
    ),
    (
      'pmp-neuromarketing-persuasion',
      $html$
<h3>Resumen practico</h3>
<p>Fundamentos de neuromarketing aplicados a servicios de salud: atencion, emocion, confianza, promesas concretas y mensajes que mueven a la accion sin prometer resultados clinicos garantizados.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/1FJ_Qp7SgFN52_765nxFWJ8462kmZ-f64/view" target="_blank" rel="noopener">Leccion 1.1 - Neuromarketing y su importancia</a></li>
  <li><a href="https://drive.google.com/file/d/1uoFtnTgqLdRh9INeV5-OgJehMf94dQ_9/view" target="_blank" rel="noopener">Leccion 1.2 - Activa codigos en el cerebro de tus pacientes</a></li>
  <li><a href="https://drive.google.com/file/d/1T_ridYS8IiSV8tiCdvL8yPWB_9sYcI7T/view" target="_blank" rel="noopener">Leccion 1.3 - Psicologia del consumidor y el paciente</a></li>
  <li><a href="https://drive.google.com/file/d/1AOzWLiMpVilRD8drDrbJjCsd-QsKO2bK/view" target="_blank" rel="noopener">Leccion 1.4 - Activa la mente de tu paciente</a></li>
  <li><a href="https://drive.google.com/file/d/1m3KkzrvK_4JvhxG31eQk0qJrPoFNJX9n/view" target="_blank" rel="noopener">Leccion 1.5 - Motivos de busqueda de ayuda profesional</a></li>
  <li><a href="https://drive.google.com/file/d/1Dv-SI-vQpDSwPUf6JKd7TZpy5PfQzkZF/view" target="_blank" rel="noopener">Leccion 1.6 - Propuesta de valor</a></li>
  <li><a href="https://drive.google.com/file/d/1GSYijjBsPpXEKB2ADHykt8ZYyaKfJ5xc/view" target="_blank" rel="noopener">Leccion 1.7 - Landing page</a></li>
  <li><a href="https://drive.google.com/file/d/1vbDqyOxvVT5llKYJxewRSh7PPJcXiXOR/view" target="_blank" rel="noopener">Leccion 1.8 - Conectando con las emociones</a></li>
</ul>
$html$
    ),
    (
      'pmp-whatsapp-trafico',
      $html$
<h3>Resumen practico</h3>
<p>Configuracion de WhatsApp Business y rutas de trafico. La meta es que cada publicacion, anuncio o contacto tenga una salida clara hacia una conversacion ordenada y medible.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/1spXZ4kKiBn5z-EpQ_ZQENlU-qcviLCGs/view" target="_blank" rel="noopener">Leccion 2.1 - Presentacion del modulo</a></li>
  <li><a href="https://drive.google.com/file/d/18ymB_hKg4bQYdGDVIUo2ZvXrImS6LTNj/view" target="_blank" rel="noopener">Leccion 2.2 - Instalando WhatsApp Business</a></li>
  <li><a href="https://drive.google.com/file/d/1Ff7nGjyRZnMzMr-m8x4BRhjLafOUu26m/view" target="_blank" rel="noopener">Leccion 2.3 - Conociendo WhatsApp Business</a></li>
  <li><a href="https://drive.google.com/file/d/1PmYej6VQ0ZPrJoARgn3SPB4v9_btwxsZ/view" target="_blank" rel="noopener">Leccion 2.4 - Disena tu imagen de perfil</a></li>
  <li><a href="https://drive.google.com/file/d/114D7RC6YGeXEf_uBWLD43yCJHjZKuozq/view" target="_blank" rel="noopener">Leccion 2.5 - Edita tu perfil</a></li>
  <li><a href="https://drive.google.com/file/d/1zvIGx1cijRm3T7iT6ppP6_bzQrx71fOr/view" target="_blank" rel="noopener">Leccion 2.6 - Completa tu perfil de empresa</a></li>
  <li><a href="https://drive.google.com/file/d/1Xn6vWIZ27C6HYvTHrppYcV04rXTcjgqp/view" target="_blank" rel="noopener">Leccion 2.7 - Potencia tu WhatsApp Business</a></li>
  <li><a href="https://drive.google.com/file/d/1A5a-W684J90O6Uc5Ym8q_WMts-qN74-w/view" target="_blank" rel="noopener">Leccion 2.8 - Disenando mi llamada a la accion</a></li>
  <li><a href="https://drive.google.com/file/d/1xBGpDTU63xwKmzjSQhJnjmgQEHVCIooy/view" target="_blank" rel="noopener">Leccion 2.9 - Probando mi llamada a la accion</a></li>
  <li><a href="https://drive.google.com/file/d/1vDdD27Kgz8ttMVDzNwoIsXuCDgxcKsyG/view" target="_blank" rel="noopener">Leccion 2.10 - Compartiendo publicaciones en Facebook</a></li>
  <li><a href="https://drive.google.com/file/d/1olYNjW5SJA0lHU19Ng7ju9_3XZaldJbh/view" target="_blank" rel="noopener">Leccion 2.11 - CTA para publicaciones con Canva</a></li>
</ul>
$html$
    ),
    (
      'pmp-estados-calendario',
      $html$
<h3>Resumen practico</h3>
<p>Uso de estados, calendario y secuencia de publicaciones para sostener presencia comercial. Se trabaja el ritmo, el contenido diario y la repeticion inteligente del mensaje.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/15YTRo0nudFp-Foa1Rtc1Z5wKukN2eJOw/view" target="_blank" rel="noopener">Leccion 3.1 - Estados de WhatsApp</a></li>
  <li><a href="https://drive.google.com/file/d/1JTjyM1YCjkfTGwQs95H2cZYroeb-MQ6_/view" target="_blank" rel="noopener">Leccion 3.2 - Activa el deseo con una publicacion</a></li>
  <li><a href="https://drive.google.com/file/d/1QETmwf8GHbbegeCyfvq-1GB59w6o9AKS/view" target="_blank" rel="noopener">Leccion 3.3 - Calendario de publicaciones</a></li>
</ul>
$html$
    ),
    (
      'pmp-mensajes-impacto',
      $html$
<h3>Resumen practico</h3>
<p>Construccion de mensajes de alto impacto: contenido para conversaciones, anuncios y publicaciones. Se enfoca en detectar dolor, deseo, objeciones y llamados a la accion.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/1QdmqaJdAdNYQUAxf4EUcx_32XL6WVqMA/view" target="_blank" rel="noopener">Leccion 4.1 - Introduccion a mensajes poderosos</a></li>
  <li><a href="https://drive.google.com/file/d/10d_lxgihDOIyqFSQXYHUB6IO0fsN4Jd9/view" target="_blank" rel="noopener">Leccion 4.2 - Estructura de mensajes</a></li>
  <li><a href="https://drive.google.com/file/d/1VYXyzgJOBFhOn-hy_8YOq1ntR1YIOGBg/view" target="_blank" rel="noopener">Leccion 4.3 - Problema, agitado y solucion</a></li>
  <li><a href="https://drive.google.com/file/d/1AAvrE4VKGBTZaX3z_VZwbrupOFJXXGtF/view" target="_blank" rel="noopener">Leccion 4.4 - Mensajes para despertar interes</a></li>
  <li><a href="https://drive.google.com/file/d/1IBssoXsMJXRFc2DFgLtualNgQvwdh2ns/view" target="_blank" rel="noopener">Leccion 4.5 - Mensajes para conversacion</a></li>
  <li><a href="https://drive.google.com/file/d/1IPMLI_cpC1HWqBIGaoN_E_-VpP1nxmOX/view" target="_blank" rel="noopener">Leccion 4.6 - Mensajes para objeciones</a></li>
  <li><a href="https://drive.google.com/file/d/1MBlFjf2GwHJQIq0pVWbp-AHy0eW6azRq/view" target="_blank" rel="noopener">Leccion 4.7 - Mensajes con urgencia</a></li>
  <li><a href="https://drive.google.com/file/d/1ZmQuiWMl33RqRrTD7WqizMyY6lWqPxXK/view" target="_blank" rel="noopener">Leccion 4.8 - Mensajes para seguimiento</a></li>
  <li><a href="https://drive.google.com/file/d/10spHO0UhjOSzgXPad6crPZR3bRrbx6cC/view" target="_blank" rel="noopener">Leccion 4.9 - Mensajes para cierre</a></li>
  <li><a href="https://drive.google.com/file/d/1nsX6x2Lcr47_RVA75Ji1WtZA5lXuQ5SK/view" target="_blank" rel="noopener">Leccion 4.10 - Mensajes de confianza</a></li>
  <li><a href="https://drive.google.com/file/d/1T5qsFasUVqtNJW8DJ4jzQIvaluzc-sPZ/view" target="_blank" rel="noopener">Leccion 4.11 - Practica de mensajes</a></li>
</ul>
$html$
    ),
    (
      'pmp-cierre-gatillos',
      $html$
<h3>Resumen practico</h3>
<p>Cierre comercial etico para consultas o servicios profesionales. Incluye gatillos mentales, confianza, escasez real, autoridad y pasos concretos para que la persona agende.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/1exCSJQ7yLubJXFr2sAY4mYyRbviItX2A/view" target="_blank" rel="noopener">Leccion 5.1 - Introduccion al cierre</a></li>
  <li><a href="https://drive.google.com/file/d/1XVk4K12U6URfTRYDrPU_-ReUL9YKgnnK/view" target="_blank" rel="noopener">Leccion 5.2 - Gatillos mentales</a></li>
  <li><a href="https://drive.google.com/file/d/1g-ywdU4DmVlFZ79GJp1bXHmWV2TIK-vA/view" target="_blank" rel="noopener">Leccion 5.3 - Autoridad y confianza</a></li>
  <li><a href="https://drive.google.com/file/d/1-dc8pq7omOjBJFj4FWSAMqnAZatc7xCF/view" target="_blank" rel="noopener">Leccion 5.4 - Urgencia y decision</a></li>
  <li><a href="https://drive.google.com/file/d/1U80-J6Mmd1F6yMDnhQz98ZNHTg6de5PT/view" target="_blank" rel="noopener">Leccion 5.5 - Objeciones antes del cierre</a></li>
  <li><a href="https://drive.google.com/file/d/199ikCQMnUdK77AuE3b8yhrhATBhZau3c/view" target="_blank" rel="noopener">Leccion 5.6 - Secuencia final de cierre</a></li>
</ul>
$html$
    ),
    (
      'pmp-facebook-ads',
      $html$
<h3>Resumen practico</h3>
<p>Primeras campanas en Facebook Ads: estructura, segmentacion, piezas creativas y lectura basica para llevar trafico hacia WhatsApp o una pagina de aterrizaje.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/1dcV3TSjki26R6D1rZjx_gV_1m5PWr-Fm/view" target="_blank" rel="noopener">Leccion 6.1 - Introduccion a Facebook Ads</a></li>
  <li><a href="https://drive.google.com/file/d/1D6vs7ImMAFUyXqdP1025zF2Hu2h60iav/view" target="_blank" rel="noopener">Leccion 6.2 - Configuracion inicial</a></li>
  <li><a href="https://drive.google.com/file/d/1Wf4SRhEJyrJqxHVCdcouZKn-a8deoQKn/view" target="_blank" rel="noopener">Leccion 6.3 - Campana y conjunto de anuncios</a></li>
  <li><a href="https://drive.google.com/file/d/165Ecz6ywpEWXTrPgE2zDcVJXnUSPmB5d/view" target="_blank" rel="noopener">Leccion 6.4 - Creativos y copy</a></li>
  <li><a href="https://drive.google.com/file/d/1X2UkIbPU_lnmmwD5_TFhhdmf2hhJ3knA/view" target="_blank" rel="noopener">Leccion 6.5 - Segmentacion</a></li>
  <li><a href="https://drive.google.com/file/d/1fgMuVe3FMcU20BSCZjmnb1r-5mrUl5rV/view" target="_blank" rel="noopener">Leccion 6.6 - Revision de anuncios</a></li>
  <li><a href="https://drive.google.com/file/d/1KZtry7A_s1KcL_if6gx69FIAQzWdEaWO/view" target="_blank" rel="noopener">Leccion 6.7 - Medicion inicial</a></li>
</ul>
$html$
    ),
    (
      'pmp-canva-ia-fanpage',
      $html$
<h3>Resumen practico</h3>
<p>Produccion visual y operativa: Canva, IA, prompts para salud, FanPage, boton de WhatsApp y publicaciones listas para convertir.</p>
<h3>Videos</h3>
<ul>
  <li><a href="https://drive.google.com/file/d/1REMGK0Vl8GK1VT50xvOpRwsq0kcdqbVn/view" target="_blank" rel="noopener">Como encontrar clientes - Curso Maquina de Pacientes</a></li>
  <li><a href="https://drive.google.com/file/d/1LIaIaCcNLLIKjqESIsCBN29T51FY3S4S/view" target="_blank" rel="noopener">Leccion 9 - Canva para crear contenido</a></li>
  <li><a href="https://drive.google.com/file/d/18b5Hvv9mzCOfOfhMpxbKrvZJ9osQoXgz/view" target="_blank" rel="noopener">Leccion 10 - Practica anuncio en Canva</a></li>
  <li><a href="https://drive.google.com/file/d/1OXlEJAr3YlrhU5CakXaCMpQH1DgYh4vh/view" target="_blank" rel="noopener">Dandole instrucciones a la inteligencia artificial</a></li>
  <li><a href="https://drive.google.com/file/d/1YDjI_4g0iMpNIngWFa6CnBJtLXMEGNaK/view" target="_blank" rel="noopener">L1 - Prompts para sector salud</a></li>
  <li><a href="https://drive.google.com/file/d/1QiVYkvY-adCwWrndC-JvjnEbLAPwp9VY/view" target="_blank" rel="noopener">L1 - Diferencia entre perfil y FanPage</a></li>
  <li><a href="https://drive.google.com/file/d/14UvVRggpNs3_8hQXF1bicozZPYrnLZKp/view" target="_blank" rel="noopener">L2 - Creando una FanPage</a></li>
  <li><a href="https://drive.google.com/file/d/1ZemaG5Xfzuur0PMMe9skv0Og3MZ8oZHW/view" target="_blank" rel="noopener">L2 - Editando con Fancy Text</a></li>
  <li><a href="https://drive.google.com/file/d/1Ls1rrSFAiSLwUnY-Vd8LKrGnkbaJHRqL/view" target="_blank" rel="noopener">L3 - Conectando boton de WhatsApp</a></li>
  <li><a href="https://drive.google.com/file/d/1GFnc7gJCG0LzNgEaibKWO_utrH7qDyan/view" target="_blank" rel="noopener">L4 - Publicando con boton de WhatsApp</a></li>
  <li><a href="https://drive.google.com/file/d/1HbnqCQs6g2-WQti7xkZPrWtrd-R-2rlM/view" target="_blank" rel="noopener">Usando Canva basado en inteligencia artificial</a></li>
</ul>
$html$
    )
) as source(id, theory)
where module.id = source.id
  and module.course_id = 'poderosa-maquina-pacientes';

commit;
