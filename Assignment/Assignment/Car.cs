//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Assignment
{
    using System;
    using System.Collections.Generic;
    
    public partial class Car
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Car()
        {
            this.Bookings = new HashSet<Booking>();
        }
    
        public string CarPlate { get; set; }
        public string CarBrand { get; set; }
        public string CarName { get; set; }
        public string CType { get; set; }
        public string CarDesc { get; set; }
        public string CarImage { get; set; }
        public Nullable<double> CarDayPrice { get; set; }
        public Nullable<int> CarSeat { get; set; }
        public string CarTransmission { get; set; }
        public string CarEnergy { get; set; }
        public Nullable<int> LocationId { get; set; }
        public Nullable<int> IsDelisted { get; set; }
    
        public virtual CarBrand CarBrand1 { get; set; }
        public virtual Location Location { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Booking> Bookings { get; set; }
    }
}
