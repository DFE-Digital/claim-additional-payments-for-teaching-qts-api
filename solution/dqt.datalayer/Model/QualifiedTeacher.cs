﻿using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace dqt.datalayer.Model
{
    public class QualifiedTeacher
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public string Trn { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public DateTime DoB { get; set; }

        public string NINumber { get; set; }

        public DateTime QTSAwardDate { get; set; }

        public string ITTSubject1Code { get; set; }

        public string ITTSubject2Code { get; set; }

        public string ITTSubject3Code { get; set; }

        public bool ActiveAlert { get; set; }
    }
}
