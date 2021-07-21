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
  {title: 'Hospitalización', value: 100, pe: '(3 Meses P/E)' },
  {title: 'UCI', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Cirugía Electiva', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Cirugía de Emergencia', value: 100, pe: nil },
  {title: 'Maternidad', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Servicios de Emergencias', value: 100, pe: nil },
  {title: 'Consultas Básicas', value: 100, pe: nil },
  {title: 'Consultas Especializadas', value: 100, pe: nil },
  {title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  {title: 'Rayos X', value: 100, pe: nil },
  {title: 'Mamografía', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Tomografía', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  {title: 'Exámenes Lab. Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Ecogramas Básicos', value: 100, pe: nil },
  {title: 'Exámenes Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Electrocardiograma', value: 100, pe: nil },
  {title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Gastroscopía', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Colonoscopía', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Mastología', value: 0, pe: '(1 Ano P/E)' }
]
coverage_items_oro = [
  {title: 'Hospitalización', value: 100, pe: '(3 Meses P/E)' },
  {title: 'UCI', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Cirugía Electiva', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Cirugía de Emergencia', value: 100, pe: nil },
  {title: 'Maternidad', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Servicios de Emergencias', value: 100, pe: nil },
  {title: 'Consultas Básicas', value: 100, pe: nil },
  {title: 'Consultas Especializadas', value: 100, pe: nil },
  {title: 'Servicios de Odontología Básica', value: 100, pe: nil },
  {title: 'Rayos X', value: 100, pe: nil },
  {title: 'Mamografía', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Tomografía', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Exámenes Lab. Básicos', value: 100, pe: nil },
  {title: 'Exámenes Lab. Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Ecogramas Básicos', value: 100, pe: nil },
  {title: 'Exámenes Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Electrocardiograma', value: 100, pe: nil },
  {title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: nil },
  {title: 'Gastroscopía', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Colonoscopía', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Mastología', value: 0, pe: '(1 Ano P/E)' }
]

unless Company.all.present?
  company = Company.create({ name: 'SIPCA ', rif: 'J-00000000-0' })
  producs = company.products.create({ description: 'Medicina Prepagada', title: 'SIPCA' })
  bronce = producs.plans.create({ coverage: 12000, coverage_items: coverage_items, payment_fee: 18, title: 'Bronce' })
  plata = producs.plans.create({ coverage: 20000, coverage_items: coverage_items, payment_fee: 25, title: 'Plata' })
  oro = producs.plans.create({ coverage: 50000, coverage_items: coverage_items_oro, payment_fee: 45, title: 'Oro' })
end
