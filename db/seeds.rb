# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

coverage_items = [
  { title: 'Hospitalización', value: 100, pe: 3 },
  { title: 'UCI', value: 100, pe: 12 },
  { title: 'Cirugía Electiva', value: 100, pe: 12 },
  { title: 'Cirugía de Emergencia', value: 100, pe: nil },
  { title: 'Maternidad', value: 100, pe: 12 },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Consultas básicas', value: 100, pe: nil },
  { title: 'Consultas especializadas', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Mamografía', value: 100, pe: 3 },
  { title: 'Tomografía', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 3 },
  { title: 'Ecogramas básicos', value: 100, pe: nil },
  { title: 'Exámenes Especiales', value: 100, pe: 3 },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: 3 },
  { title: 'Gastroscopia', value: 100, pe: 12 },
  { title: 'Colonoscopia', value: 100, pe: 12 },
  { title: 'Mastología', value: 0, pe: 12 }
]
coverage_items_oro = [
  { title: 'Hospitalización', value: 100, pe: 3 },
  { title: 'UCI', value: 100, pe: 6 },
  { title: 'Cirugía Electiva', value: 100, pe: 12 },
  { title: 'Cirugía de Emergencia', value: 100, pe: nil },
  { title: 'Maternidad', value: 100, pe: 12 },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Consultas básicas', value: 100, pe: nil },
  { title: 'Consultas especializadas', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Mamografía', value: 100, pe: 6 },
  { title: 'Tomografía', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 3 },
  { title: 'Ecogramas básicos', value: 100, pe: nil },
  { title: 'Exámenes Especiales', value: 100, pe: 3 },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: nil },
  { title: 'Gastroscopia', value: 100, pe: 6 },
  { title: 'Colonoscopia', value: 100, pe: 6 },
  { title: 'Mastología', value: 0, pe: 12 }
]
coverage_items_platino1 = [
  { title: 'Cirugía Electiva', value: 0, pe: nil },
  { title: 'Colonoscopia', value: 0, pe: nil },
  { title: 'Consultas básicas ilimitadas', value: 100, pe: nil },
  { title: 'Telemedicina', value: 100, pe: nil },
  { title: 'Consultas especializadas', value: 100, pe: 6 },
  { title: 'Ecocardiograma, Mapa, Holter', value: 0, pe: nil },
  { title: 'Ecogramas básicos', value: 100, pe: 6 },
  { title: 'Ecogramas especializados', value: 0, pe: nil },
  { title: 'Electrocardiograma', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: 6 },
  { title: 'Exámenes Lab. Especiales', value: 0, pe: nil },
  { title: 'Gastroscopia', value: 0, pe: nil },
  { title: 'Hospitalización', value: 0, pe: nil },
  { title: 'Mamografía (1 x Año)', value: 0, pe: nil },
  { title: 'Rayos X estudios simples', value: 100, pe: 6 },
  { title: 'Servicios de Emergencias', value: 0, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Tomografía (1 x Año)', value: 0, pe: nil },
  { title: 'UCI', value: 0, pe: nil },
  { title: 'Cirugía de Emergencia', value: 0, pe: nil },
]
coverage_items_platino2 = [
  { title: 'Cirugía Electiva', value: 0, pe: nil },
  { title: 'Colonoscopia', value: 0, pe: nil },
  { title: 'Consultas básicas ilimitadas', value: 100, pe: nil },
  { title: 'Telemedicina', value: 100, pe: nil },
  { title: 'Consultas especializadas', value: 100, pe: 3 },
  { title: 'Ecocardiograma, Mapa, Holter', value: 0, pe: nil },
  { title: 'Ecogramas básicos', value: 100, pe: nil },
  { title: 'Ecogramas especializados', value: 100, pe: 6 },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 6 },
  { title: 'Gastroscopia', value: 0, pe: nil },
  { title: 'Hospitalización', value: 0, pe: nil },
  { title: 'Mamografía (1 x Año)', value: 0, pe: nil },
  { title: 'Rayos X estudios simples', value: 100, pe: 3 },
  { title: 'Servicios de Emergencias', value: nil, pe: 6 },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Tomografía (1 x Año)', value: 100, pe: 6 },
  { title: 'UCI', value: 0, pe: nil },
  { title: 'Cirugía de Emergencia', value: 0, pe: nil },
]
coverage_items_platino3 = [
  { title: 'Cirugía Electiva', value: 100, pe: 12 },
  { title: 'Colonoscopia', value: 100, pe: 12 },
  { title: 'Consultas básicas ilimitadas', value: 100, pe: nil },
  { title: 'Telemedicina', value: 100, pe: nil },
  { title: 'Consultas especializadas', value: 100, pe: nil },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: 3 },
  { title: 'Ecogramas básicos', value: 100, pe: nil },
  { title: 'Ecogramas especializados', value: 100, pe: 3 },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 3 },
  { title: 'Gastroscopia', value: 100, pe: 12 },
  { title: 'Hospitalización', value: 100, pe: 6 },
  { title: 'Mamografía (1 x Año)', value: 100, pe: 6 },
  { title: 'Rayos X estudios simples', value: 100, pe: nil },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Tomografía (1 x Año)', value: 100, pe: 3 },
  { title: 'UCI', value: 0, pe: nil },
  { title: 'Cirugía de Emergencia', value: 100, pe: nil },
]
coverage_items_bronce_empleado = [
  { title: 'Cirugía Electiva', value: 100, pe: 12 },
  { title: 'Consultas básicas', value: 100, pe: nil },
  { title: 'Telemedicina', value: 100, pe: nil },
  { title: 'Consultas especializadas', value: 100, pe: 6 },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: 12 },
  { title: 'Ecogramas básicos', value: 100, pe: 3 },
  { title: 'Ecogramas especializados', value: 100, pe: 8 },
  { title: 'Electrocardiograma', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 8 },
  { title: 'Hospitalización', value: 100, pe: 9 },
  { title: 'Mamografía (1 x Año)', value: 100, pe: 12 },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: 6 },
  { title: 'Colonoscopia', value: 0, pe: nil },
  { title: 'Gastroscopia', value: 0, pe: nil },
]
coverage_items_plata_empleado = [
  { title: 'Cirugía Electiva', value: 100, pe: 12 },
  { title: 'Consultas básicas', value: 100, pe: nil },
  { title: 'Telemedicina', value: 100, pe: nil },
  { title: 'Consultas especializadas', value: 100, pe: 3 },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: 6 },
  { title: 'Ecogramas básicos', value: 100, pe: 1 },
  { title: 'Ecogramas especializados', value: 100, pe: 6 },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: 1 },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 6 },
  { title: 'Hospitalización', value: 100, pe: 6 },
  { title: 'Mamografía (1 x Año)', value: 100, pe: 6 },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: 3 },
  { title: 'Colonoscopia', value: 100, pe: 8 },
  { title: 'Gastroscopia', value: 100, pe: 8 },
]

unless Disease.all.present?
  Disease.create([
    {
      title: 'ENFERMEDADES CARDIOVASCULARES',
      list_diases: ["Hipertensión Arterial", " infarto al Miocardio", " Arritmia Cardiaca", " Aneurisma", " Palpitaciones", " Angina de Pecho", " Fiebre Reumática", " Arteriosclerosis", " Trastornos Valvulares", " Tromboflebitis", " Varices"],
      has_description: false,
      order: 1,
    }, {
      title: 'ENFERMEDADES DE LAS VÍAS RESPIRATORIAS',
      list_diases: ["Ronquera", " tos persistente", " bronquitis", " asma", " enfisema", " tuberculosis", " pleuresía", " neumonía", " bronconeumonía."],
      has_description: false,
      order: 2,
    }, {
      title: 'ENFERMEDADES DE LAS VÍAS DIGESTIVAS',
      list_diases: ["Gastritis", " Ulceras", " Hepatitis", " Cirrosis", " Hemorroides o similares", " Apendicitis", " colitis", " Litiasis Vesicular", " hernias hiatales", " fisura anal"],
      has_description: false,
      order: 3,
    }, {
      title: 'ENFERMEDADES DEL SISTEMA ENDOCRINO',
      list_diases: ["Diabetes", " Obesidad", " Tiroides", " Paratiroides."],
      has_description: false,
      order: 4,
    }, {
      title: 'ENFERMEDADES OSTEOMUSCULARES',
      list_diases: ["Neuritis", " Ciática", " Reumatismo", " Hernias Discales", " Artritis", " Osteoporosis", " Desviación de la Columna Vertebral", " Problemas en las Articulaciones."],
      has_description: false,
      order: 5,
    }, {
      title: 'ENFERMEDADES GENITO-URINARIAS',
      list_diases: ["Cálculos u otra alteración en los riñones", " vejiga o próstata", " prostatitis", " varicocele."],
      has_description: false,
      order: 6,
    }, {
      title: 'ENFERMEDADES DE LA PIEL, OJOS, OÍDOS, NARÍZ, GARGANTA',
      list_diases: ["Desviación del Tabique Nasal", " Sinusitis", " Amigdalitis", " Rinitis", " Otitis", " Cataratas", " Hipertrofia de Cornetes"],
      has_description: false,
      order: 7,
    }, {
      title: 'ENFERMEDADES TRANSITORIAS CRÓNICAS O ALGÚN DEFECTOS NO MENCIONADOS ANTERIORMENTE',
      list_diases: nil,
      has_description: false,
      order: 8,
    }, {
      title: 'ENFERMEDADES PROPIAS DE LA MUJER',
      list_diases: ["Fibroma Uterino", " Prolapso", " Obstrucción en las Trompas", " Ovarios Poliquisticos", " Patologías Mamarias", " Endometriosis."],
      has_description: false,
      order: 9,
    }, {
      title: 'LE HA SIDO INDICADA O PRACTICADA ALGUNA INTERVENCIÓN QUIRÚRGICA O SE HA SOMETIDO A TRATAMIENTO MÉDICO POR ALGUNA ENFERMEDAD O LESIÓN ADICIONAL A LAS ANTERIORES.',
      list_diases: nil,
      has_description: true,
      order: 10,
    }, {
      title: '11. OTROS (Especifique).',
      list_diases: nil,
      has_description: true,
      order: 11,
    }])
end

unless Company.all.present?
  company = Company.create({ name: 'SIPCA ', rif: 'J-00000000-0' })
  products = company.products.create({ description: 'Medicina Prepagada', title: 'SIPCA' })
  products.plans.create({ coverage: 12_000,
                          coverage_items: coverage_items,
                          payment_fee: 18, title: 'Bronce', age_limit: 60, age_min: nil })
  products.plans.create({ coverage: 20_000,
                          coverage_items: coverage_items, payment_fee: 25,
                          title: 'Plata', age_limit: 60, age_min: nil })
  products.plans.create({ coverage: 50_000,
                          coverage_items: coverage_items_oro, payment_fee: 45,
                          title: 'Oro', age_limit: 60, age_min: nil })
  products.plans.create({ coverage: 10_000,
                          coverage_items: coverage_items_platino1, payment_fee: 18,
                          title: 'Platino 1', age_limit: 81, age_min: 61 })
  products.plans.create({ coverage: 10_000,
                          coverage_items: coverage_items_platino2, payment_fee: 36,
                          title: 'Platino 2', age_limit: 81, age_min: 61 })
  products.plans.create({ coverage: 10_000,
                          coverage_items: coverage_items_platino3, payment_fee: 52,
                          title: 'Platino 3', age_limit: 81, age_min: 61 })
  products.plans.create({ coverage: 4_000,
                          coverage_items: coverage_items_bronce_empleado, payment_fee: 10,
                          title: 'Bronce Empleado', age_limit: nil, age_min: nil, own: true })
  products.plans.create({ coverage: 6_000,
                          coverage_items: coverage_items_plata_empleado, payment_fee: 12,
                          title: 'Plata Empleado', age_limit: nil, age_min: nil, own: true })
end
if Customer.all.present?
  child = Customer.create(firstname: 'Mohammad Heath',second_name: 'Eaton',last_name: 'Larsen',dni: '22123456',birthday: '1995-05-04', age: 26,sex: 0,size: 'M',parent_id: Customer.first.id,plan_id: Plan.first.id,is_insured: true,customer_code: '02')
end

unless State.all.present?
  response = HTTParty.get('https://raw.githubusercontent.com/zokeber/venezuela-json/master/venezuela.json')
  states = JSON.parse(response.body)

  states.each do |state|
    new_state = State.create({
      title: state["estado"],
      capital: state["capital"],
      cities: state["ciudades"]
    })

    state["municipios"].each do |muny|
      new_state.municipalities.create({
        title: muny["municipio"],
        capital: muny["capital"],
        parish: muny["parroquias"] 
      })
    end
  end
end

# enum module_name: {
# products: 0,
# plans: 1,
# users: 2,
# customers: 3,
# admin_dashboars: 4,
# scales: 5,
# }
sections = [
  { name: 'list_products', pretty_name: 'Productos', module_name: 0 },
  { name: 'plans', pretty_name: 'Planes', module_name: 1 },
  { name: 'create_plans', pretty_name: 'Crear Planes', module_name: 1 },
  { name: 'edit_plans', pretty_name: 'Editar Planes', module_name: 1 },
  { name: 'users', pretty_name: 'Usuarios', module_name: 2 },
  { name: 'create_users', pretty_name: 'Crear Usuarios', module_name: 2 },
  { name: 'edit_users', pretty_name: 'Editar Usuarios', module_name: 2 },
  { name: 'customers', pretty_name: 'Clientes', module_name: 3 },
  { name: 'create_customers', pretty_name: 'Crear Clientes', module_name: 3 },
  { name: 'show_customers', pretty_name: 'Ver Cliente', module_name: 3 },
  { name: 'authorize_customers', pretty_name: 'Autorizar Clientes', module_name: 3 },
  { name: 'edit_customers', pretty_name: 'Editar Clientes', module_name: 3 },
  { name: 'list_scales', pretty_name: 'Baremo', module_name: 5 },
  { name: 'create_scales', pretty_name: 'Crear Items Baremo', module_name: 5 },
  { name: 'edit_scales', pretty_name: 'Editar Items Baremo', module_name: 5 }
]
existing_sections = Section.all.pluck(:name)
new_sections = sections.reject { |s| existing_sections.include?(s[:name]) }
Section.create(new_sections)

# Create user for tests
if User.find_by_email('admin@sipca.com').nil?
  permissions_attributes = Section.all.map do |section|
    { section_id: section.id, active: true }
  end
  User.create(
    first_name: 'Admin', last_name: 'Sipca', email: 'admin@sipca.com', password: '12345678',
    permissions_attributes: permissions_attributes
  )
end

if Scale.count.zero?
  Scale.create([
    {
      title: 'Absceso Sebaceo',
      amount: 700,
      category: 0,
      status: 1
    },{
      title: 'Apendicitis Adultos',
      amount: 1890,
      category: 0,
      status: 1
    },{
      title: 'Colecistectomia (ABIERTA/LAP)',
      amount: 1890,
      category: 0,
      status: 1
    },{
      title: 'Eventracion',
      amount: 1600,
      category: 0,
      status: 1
    },{
      title: 'Hemorroidectomia',
      amount: 1300,
      category: 0,
      status: 1
    },{
      title: 'Hernia Inglinal Bilateral',
      amount: 1220,
      category: 0,
      status: 1
    },{
      title: 'Hernia Umbilical',
      amount: 1100,
      category: 0,
      status: 1
    },{
      title: 'Hernia Epigastrica',
      amount: 1600,
      category: 0,
      status: 1
    },{
      title: 'Tiroidectomia Parcial',
      amount: 2100,
      category: 0,
      status: 1
    },{
      title: 'Tiroidectomia Total',
      amount: 2550,
      category: 0,
      status: 1
    },{
      title: 'Cesarea Segmentaria',
      amount: 1650,
      category: 1,
      status: 1
    },{
      title: 'Cesarea Gemelar',
      amount: 1900,
      category: 1,
      status: 1
    },{
      title: 'Histectomia Abdominal',
      amount: 2500,
      category: 1,
      status: 1
    },{
      title: 'Legrado Uterino',
      amount: 780,
      category: 1,
      status: 1
    },{
      title: 'Parto Eutocico',
      amount: 1150,
      category: 1,
      status: 1
    },{
      title: 'Amigdalectomia',
      amount: 1250,
      category: 2,
      status: 1
    },{
      title: 'Quiste Sinovial',
      amount: 920,
      category: 3,
      status: 1
    },{
      title: 'Tunel Carpiano',
      amount: 920,
      category: 3,
      status: 1
    },{
      title: 'Gastroscopia',
      amount: 450,
      category: 4,
      status: 1
    },{
      title: 'Colonoscopia',
      amount: 590,
      category: 4,
      status: 1
    },{
      title: 'Gastrocolonoscopia',
      amount: 750,
      category: 4,
      status: 1
    },{
      title: 'Ecograms Sencillos',
      amount: 45,
      category: 5,
      status: 1
    },{
      title: 'Ecogramas Especiales',
      amount: 55,
      category: 5,
      status: 1
    },{
      title: 'Doppler Venoso Arteial SUP/INF',
      amount: 100,
      category: 5,
      status: 1
    },{
      title: 'Servicio de Hosp. Privada',
      amount: 220,
      category: 6,
      status: 1
    },{
      title: 'Honorarios Medicos Profesionales',
      amount: 120,
      category: 6,
      status: 1
    },{
      title: 'Terapia Intensiva Adulto',
      amount: 1800,
      category: 6,
      status: 1
    },{
      title: 'Terapia Intensiva Pediatrica',
      amount: 1800,
      category: 6,
      status: 1
    },{
      title: 'Honorarios Medicos UCI',
      amount: 400,
      category: 6,
      status: 1
    },{
      title: 'Intubacion Traqueal',
      amount: 320,
      category: 6,
      status: 1
    },{
      title: 'Consultas Basicas',
      amount: 45,
      category: 7,
      status: 1
    },{
      title: 'Consultas de Especialistas',
      amount: 55,
      category: 7,
      status: 1
    },{
      title: 'Ecocardiograma Adulto',
      amount: 45,
      category: 8,
      status: 1
    },{
      title: 'Mapa',
      amount: 60,
      category: 8,
      status: 1
    },{
      title: 'Holter',
      amount: 60,
      category: 8,
      status: 1
    },{
      title: 'Electrocardiograma',
      amount: 20,
      category: 8,
      status: 1
    },{
      title: 'CPK',
      amount: 9,
      category: 9,
      status: 1
    },{
      title: 'LHD',
      amount: 11,
      category: 9,
      status: 1
    },{
      title: 'Troponina',
      amount: 9,
      category: 9,
      status: 1
    },{
      title: 'VDRL',
      amount: 12,
      category: 9,
      status: 1
    },{
      title: 'PCR',
      amount: 9,
      category: 9,
      status: 1
    },{
      title: 'Toxo Test Iha',
      amount: 7,
      category: 9,
      status: 1
    },{
      title: 'Toxo Test IGM - IGG',
      amount: 9,
      category: 9,
      status: 1
    },{
      title: 'H. Pilory',
      amount: 20,
      category: 9,
      status: 1
    },{
      title: 'PSA',
      amount: 9,
      category: 9,
      status: 1
    },{
      title: 'Hormonas Tiroideas (TSH-T3-T4)',
      amount: 9,
      category: 9,
      status: 1
    },{
      title: 'Insulina Basal y Post Pandrial',
      amount: 15,
      category: 9,
      status: 1
    },{
      title: 'Glicemia Basal / Post Pandrial',
      amount: 15,
      category: 9,
      status: 1
    },{
      title: 'Tomografia Simple',
      amount: 140,
      category: 10,
      status: 1
    },{
      title: 'Urotac Simple',
      amount: 140,
      category: 10,
      status: 1
    },{
      title: 'Rayos X (1 Proyeccion)',
      amount: 30,
      category: 10,
      status: 1
    },{
      title: 'Mamografia',
      amount: 80,
      category: 10,
      status: 1
    },{
      title: 'Espirometria',
      amount: 120,
      category: 10,
      status: 1
    },{
      title: 'Uso de Emergencia',
      amount: 120,
      category: 11,
      status: 1
    },{
      title: 'Sala de Cura (Cirugia Menor)',
      amount: 150,
      category: 11,
      status: 1
    },{
      title: 'Uso de Trauma Shock',
      amount: 160,
      category: 11,
      status: 1
    },{
      title: 'Terapia Respiratoria',
      amount: 25,
      category: 11,
      status: 1
    },{
      title: 'Servicio de Enfermeria',
      amount: 30,
      category: 11,
      status: 1
    },{
      title: 'Hematologia Completa',
      amount: 10,
      category: 12,
      status: 1
    },{
      title: 'Plaquetas',
      amount: 10,
      category: 12,
      status: 1
    },{
      title: 'Fibrinogeno',
      amount: 10,
      category: 12,
      status: 1
    },{
      title: 'Glicemia',
      amount: 7,
      category: 12,
      status: 1
    },{
      title: 'Urea',
      amount: 7,
      category: 12,
      status: 1
    },{
      title: 'Creatinina',
      amount: 9,
      category: 12,
      status: 1
    },{
      title: 'Acido urico',
      amount: 9,
      category: 12,
      status: 1
    },{
      title: 'Colesterol',
      amount: 9,
      category: 12,
      status: 1
    },{
      title: 'Trigliceridos',
      amount: 9,
      category: 12,
      status: 1
    },{
      title: 'Perfil Lipidico',
      amount: 35,
      category: 12,
      status: 1
    },{
      title: 'Proteorama',
      amount: 7,
      category: 12,
      status: 1
    },{
      title: 'TGO - TGP',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Fosfatasa Alcalina',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Amilasa',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Bilirrubina Total y Fraccionada',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Calcio',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Magnesio',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Fosforo',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Factor Reumatoideo',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Aslo',
      amount: 12,
      category: 12,
      status: 1
    },{
      title: 'Orina Completa',
      amount: 7,
      category: 12,
      status: 1
    },{
      title: 'Depuracion de creatinina',
      amount: 9,
      category: 12,
      status: 1
    },{
      title: 'Proteinuria',
      amount: 7,
      category: 12,
      status: 1
    },{
      title: 'Heces Directos',
      amount: 7,
      category: 12,
      status: 1
    }
  ])
end