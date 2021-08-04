# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create user for tests
if User.find_by_email('admin@sipca.com').nil?
  User.create(first_name: 'Admin', last_name: 'Sipca', email: 'admin@sipca.com', password: '12345678')
end

coverage_items = [
  { title: 'Hospitalización', value: 100, pe: 3 },
  { title: 'UCI', value: 100, pe: 12 },
  { title: 'Cirugía Electiva', value: 100, pe: 12 },
  { title: 'Cirugía de Emergencia', value: 100, pe: nil },
  { title: 'Maternidad', value: 100, pe: 12 },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Consultas Básicas', value: 100, pe: nil },
  { title: 'Consultas Especializadas', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Mamografía', value: 100, pe: 3 },
  { title: 'Tomografía', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 3 },
  { title: 'Ecogramas Básicos', value: 100, pe: nil },
  { title: 'Exámenes Especiales', value: 100, pe: 3 },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: 3 },
  { title: 'Gastroscopía', value: 100, pe: 12 },
  { title: 'Colonoscopía', value: 100, pe: 12 },
  { title: 'Mastología', value: 0, pe: 12 }
]
coverage_items_oro = [
  { title: 'Hospitalización', value: 100, pe: 3 },
  { title: 'UCI', value: 100, pe: 6 },
  { title: 'Cirugía Electiva', value: 100, pe: 12 },
  { title: 'Cirugía de Emergencia', value: 100, pe: nil },
  { title: 'Maternidad', value: 100, pe: 12 },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Consultas Básicas', value: 100, pe: nil },
  { title: 'Consultas Especializadas', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Mamografía', value: 100, pe: 6 },
  { title: 'Tomografía', value: 100, pe: 3 },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: 3 },
  { title: 'Ecogramas Básicos', value: 100, pe: nil },
  { title: 'Exámenes Especiales', value: 100, pe: 3 },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: nil },
  { title: 'Gastroscopía', value: 100, pe: 6 },
  { title: 'Colonoscopía', value: 100, pe: 6 },
  { title: 'Mastología', value: 0, pe: 12 }
]

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
    has_description: false,
    order: 10,
  }, {
    title: '11. OTROS (Especifique).',
    list_diases: nil,
    has_description: true,
    order: 11,
  }])

unless Company.all.present?
  company = Company.create({ name: 'SIPCA ', rif: 'J-00000000-0' })
  products = company.products.create({ description: 'Medicina Prepagada', title: 'SIPCA' })
  bronce = products.plans.create({ coverage: 12_000, coverage_items: coverage_items, payment_fee: 18, title: 'Bronce', age_limit: 60 })
  plata = products.plans.create({ coverage: 20_000, coverage_items: coverage_items, payment_fee: 25, title: 'Plata', age_limit: 60 })
  oro = products.plans.create({ coverage: 50_000, coverage_items: coverage_items_oro, payment_fee: 45, title: 'Oro', age_limit: 60 })
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