using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Assignment.Models
{
    [Serializable]
    public class PointsRecord
    {
        public DateTime Date { get; set; }
        public int Points { get; set; }
        public bool IsEarned { get; set; } // true for earned, false for used
        public string RedeemDescription { get; set; }
    }
}