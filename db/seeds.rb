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
  { title: 'Hospitalización', value: 100, pe: '(3 Meses P/E)' },
  { title: 'UCI', value: 100, pe: '(1 Ano P/E)' },
  { title: 'Cirugía Electiva', value: 100, pe: '(1 Ano P/E)' },
  { title: 'Cirugía de Emergencia', value: 100, pe: nil },
  { title: 'Maternidad', value: 100, pe: '(1 Ano P/E)' },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Consultas Básicas', value: 100, pe: nil },
  { title: 'Consultas Especializadas', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Mamografía', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Tomografía', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Ecogramas Básicos', value: 100, pe: nil },
  { title: 'Exámenes Especiales', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Gastroscopía', value: 100, pe: '(1 Ano P/E)' },
  { title: 'Colonoscopía', value: 100, pe: '(1 Ano P/E)' },
  { title: 'Mastología', value: 0, pe: '(1 Ano P/E)' }
]
coverage_items_oro = [
  { title: 'Hospitalización', value: 100, pe: '(3 Meses P/E)' },
  { title: 'UCI', value: 100, pe: '(6 Meses P/E)' },
  { title: 'Cirugía Electiva', value: 100, pe: '(1 Ano P/E)' },
  { title: 'Cirugía de Emergencia', value: 100, pe: nil },
  { title: 'Maternidad', value: 100, pe: '(1 Ano P/E)' },
  { title: 'Servicios de Emergencias', value: 100, pe: nil },
  { title: 'Consultas Básicas', value: 100, pe: nil },
  { title: 'Consultas Especializadas', value: 100, pe: nil },
  { title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  { title: 'Rayos X', value: 100, pe: nil },
  { title: 'Mamografía', value: 100, pe: '(6 Meses P/E)' },
  { title: 'Tomografía', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  { title: 'Exámenes Lab. Especiales', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Ecogramas Básicos', value: 100, pe: nil },
  { title: 'Exámenes Especiales', value: 100, pe: '(3 Meses P/E)' },
  { title: 'Electrocardiograma', value: 100, pe: nil },
  { title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: nil },
  { title: 'Gastroscopía', value: 100, pe: '(6 Meses P/E)' },
  { title: 'Colonoscopía', value: 100, pe: '(6 Meses P/E)' },
  { title: 'Mastología', value: 0, pe: '(1 Ano P/E)' }
]

diagnosis = [
  {
    title: 'ENFERMEDADES CARDIOVASCULARES',
    diseases: 'Hipertensión Arterial, infarto al Miocardio, Arritmia Cardiaca, Aneurisma, Palpitaciones, Angina de Pecho, Fiebre Reumática, Arteriosclerosis, Trastornos Valvulares, Tromboflebitis, Varices',
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES DE LAS VÍAS RESPIRATORIAS',
    dieases: 'Ronquera, tos persistente, bronquitis, asma, enfisema, tuberculosis, pleuresía, neumonía, bronconeumonía.',
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES DE LAS VÍAS DIGESTIVAS',
    dieases: 'Gastritis, Ulceras, Hepatitis, Cirrosis, Hemorroides o similares, Apendicitis, colitis, Litiasis Vesicular, hernias hiatales, fisura anal',
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES DEL SISTEMA ENDOCRINO',
    dieases: 'Diabetes, Obesidad, Tiroides, Paratiroides.',
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES OSTEOMUSCULARES',
    dieases: 'Neuritis, Ciática, Reumatismo, Hernias Discales, Artritis, Osteoporosis, Desviación de la Columna Vertebral, Problemas en las Articulaciones.',
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES GENITO-URINARIAS',
    dieases: 'Cálculos u otra alteración en los riñones, vejiga o próstata, prostatitis, varicocele.',
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES DE LA PIEL, OJOS, OÍDOS, NARÍZ, GARGANTA',
    dieases: 'Desviación del Tabique Nasal, Sinusitis, Amigdalitis, Rinitis, Otitis, Cataratas, Hipertrofia de Cornetes',
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES TRANSITORIAS CRÓNICAS O ALGÚN DEFECTOS NO MENCIONADOS ANTERIORMENTE',
    dieases: nil,
    diagnosed: nil
  }, {
    title: 'ENFERMEDADES PROPIAS DE LA MUJER',
    dieases: 'Fibroma Uterino, Prolapso, Obstrucción en las Trompas, Ovarios Poliquisticos, Patologías Mamarias, Endometriosis.',
    diagnosed: nil
  }, {
    title: 'LE HA SIDO INDICADA O PRACTICADA ALGUNA INTERVENCIÓN QUIRÚRGICA O SE HA SOMETIDO A TRATAMIENTO MÉDICO POR ALGUNA ENFERMEDAD O LESIÓN ADICIONAL A LAS ANTERIORES.',
    dieases: nil,
    diagnosed: nil
  }, {
    title: '11. OTROS (Especifique).',
    dieases: nil,
    diagnosed: nil
  }
]

unless Company.all.present?
  company = Company.create({ name: 'SIPCA ', rif: 'J-00000000-0' })
  producs = company.products.create({ description: 'Medicina Prepagada', title: 'SIPCA' })
  bronce = producs.plans.create({ coverage: 12_000, coverage_items: coverage_items, payment_fee: 18, title: 'Bronce' })
  plata = producs.plans.create({ coverage: 20_000, coverage_items: coverage_items, payment_fee: 25, title: 'Plata' })
  oro = producs.plans.create({ coverage: 50_000, coverage_items: coverage_items_oro, payment_fee: 45, title: 'Oro' })
end
