import {
  Bike,
  Coffee,
  Dices,
  Footprints,
  Goal,
  MapPin,
  Mountain,
  MountainSnow,
  Music,
  Target,
  Tent,
  Volleyball,
  CircleDot,
  type LucideIcon,
} from "lucide-react";

export const CATEGORY_ICONS: Record<string, LucideIcon> = {
  "Futbol": Goal,
  "Basketbol": Target,
  "Voleybol": Volleyball,
  "Tenis": CircleDot,
  "Koşu": Footprints,
  "Bisiklet": Bike,
  "Yürüyüş": Mountain,
  "Kamp": Tent,
  "Kayak": MountainSnow,
  "Masa Oyunu": Dices,
  "Konser": Music,
  "Kahve & Sosyal Buluşma": Coffee,
  "Diğer": MapPin,
};

export function getCategoryIcon(categoryName: string): LucideIcon {
  return CATEGORY_ICONS[categoryName] ?? MapPin;
}
